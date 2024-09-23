import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country/country.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;
import '../model/user_model.dart';
import 'role_services.dart';

class UserServices {
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('User');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

// get all users
  Future<List<UserModel?>> getAll() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    if (querySnapshot.docs.isNotEmpty) {
      List<DocumentSnapshot> docList = querySnapshot.docs;

      List<Future<UserModel?>> futures = docList
          .map((doc) => UserServices().fromDocumentSnapshot(doc))
          .toList();

      return await Future.wait(futures);
    } else {
      return List.empty();
    }
  }

  // get user by id
  Future<UserModel?> get(String id) {
    return _collectionRef.doc(id).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        return UserServices().fromDocumentSnapshot(doc);
      } else {
        print('Document does not exist on the database');
        return null;
      }
    });
  }

  // get user by custom field
  Future<List<UserModel?>> getBy(String fieldName, String value) async {
    List<UserModel?> dataList = List.empty(growable: true);

    QuerySnapshot querySnapshot = await _collectionRef.get();

    final List<QueryDocumentSnapshot<Object?>> allDoc =
        querySnapshot.docs.toList();

    for (var doc in allDoc) {
      if (doc.get(fieldName) == value) {
        UserModel? user = await UserServices().fromDocumentSnapshot(doc);

        if (user != null) {
          dataList.add(user);
        }
      }
    }

    return dataList;
  }

  // create an userModel object based on Firebase User object
  Future<UserModel?> getUserModelFromFirebase(User? user) async {
    if (user != null) {
      String email = user.email.toString();

      final users = await UserServices().getBy('email', email);

      return users.first;
    } else {
      return null;
    }
  }

  // convert DocumentSnapshot to userModel object
  Future<UserModel?> fromDocumentSnapshot(DocumentSnapshot<Object?> doc) async {
    return UserModel(
      id: doc.get('id'),
      email: doc.get('email'),
      name: doc.get('name'),
      birthday: doc.get('birthday') == null
          ? doc.get('birthday')
          : doc.get('birthday').toDate(),
      phone: doc.get('phone'),
      bio: doc.get('bio'),
      address: doc.get('address'),
      country: Countries.values
          .firstWhere((country) => country.number == doc.get('country')),
      avatarPath: doc.get('avatarPath'),
      avatarURL: doc.get('avatarURL'),
      role: await RoleServices().get(doc.get('role')),
      createdAt: doc.get('createdAt').toDate(),
      updatedAt: doc.get('updatedAt').toDate(),
      disableAt: doc.get('disableAt') == null
          ? doc.get('disableAt')
          : doc.get('disableAt').toDate(),
      password: doc.get('password'),
    );
  }

  // convert QueryDocumentSnapshot to userModel object
  Future<UserModel?> fromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Object?> doc) async {
    return UserModel(
      id: doc.get('id'),
      email: doc.get('email'),
      name: doc.get('name'),
      birthday: doc.get('birthday') == null
          ? doc.get('birthday')
          : doc.get('birthday').toDate(),
      phone: doc.get('phone'),
      address: doc.get('address'),
      bio: doc.get('bio'),
      country: Countries.values
          .firstWhere((country) => country.number == doc.get('country')),
      avatarPath: doc.get('avatarPath'),
      avatarURL: doc.get('avatarURL'),
      role: await RoleServices().get(doc.get('role')),
      createdAt: doc.get('createdAt').toDate(),
      updatedAt: doc.get('updatedAt').toDate(),
      disableAt: doc.get('disableAt') == null
          ? doc.get('disableAt')
          : doc.get('disableAt').toDate(),
      password: doc.get('password'),
    );
  }

  // update user details (name, birthday, phone, address, country)
  Future updateDetails({
    required UserModel user,
    required String? name,
    required DateTime? birthday,
    required String? phone,
    required String? address,
    required String? bio,
    required String countryNumber,
  }) async {
    try {
      dynamic result = _collectionRef.doc(user.id).update({
        'name': name,
        'birthday': birthday,
        'phone': phone,
        'address': address,
        'bio': bio,
        'country': countryNumber,
        'updatedAt': DateTime.now(),
      }).then((value) => print("User Updated"));

      print(result.toString());

      await UserServices()
          .get(_auth.currentUser!.uid)
          .then((currentUser) async {
        print("Get current user");
      });

      return true;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());

      return false;
    }
  }

  // update avatar
  Future updateAvatar({
    required File imageFile,
    required UserModel user,
  }) async {
    try {
      if (user.avatarPath != null && user.avatarURL != null) {
        print("Previous file exist");

        // delete previous file
        final Reference ref = _firebaseStorage.ref().child(user.avatarPath!);
        await ref.delete();

        print("Previous file deleted");
      }

      // UPLOAD TO FIREBASE STORAGE
      // Get file extension
      String extension = path.extension(imageFile.path);
      print("Extension: $extension");

      // Create the file metadata
      final metadata = SettableMetadata(contentType: "image/jpeg");

      // Create a reference to the file path in Firebase Storage
      final storageRef =
          _firebaseStorage.ref().child('avatar/${user.id}$extension');

      // Upload the file to Firebase Storage
      final uploadTask = storageRef.putFile(imageFile, metadata);

      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress = 100.0 *
                (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            print("Upload is $progress% complete.");
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            // Handle unsuccessful uploads
            print("Upload encounter error");
            throw Exception();
          case TaskState.success:
            // Handle successful uploads on complete
            print("Avatar uploaded");
            break;
        }
      });

      // Get the download URL of the uploaded file
      final downloadUrl =
          await uploadTask.then((TaskSnapshot taskSnapshot) async {
        final url = await taskSnapshot.ref.getDownloadURL();
        return url;
      });

      print("URL: $downloadUrl");

      // UPDATE ON FIRESTORE
      // update user on db
      _collectionRef.doc(user.id).update({
        'avatarPath': 'avatar/${user.id}$extension',
        'avatarURL': downloadUrl,
        'updated_at': DateTime.now(),
      }).then((value) => print("Avatar Path Updated on Firestore"));

      return true;
    } catch (e) {
      print("Error occured: ${e.toString()}");
      Fluttertoast.showToast(msg: e.toString());

      return false;
    }
  }

  // remove avatar
  Future removeAvatar({
    required UserModel user,
  }) async {
    try {
      if (user.avatarPath != null && user.avatarURL != null) {
        print("Previous file exist");

        // delete previous file
        final Reference ref = _firebaseStorage.ref().child(user.avatarPath!);
        await ref.delete();

        // update user on db
        _collectionRef.doc(user.id).update({
          'avatarPath': null,
          'avatarURL': null,
          'updated_at': DateTime.now(),
        }).then((value) => print("Avatar Path Updated to Null on Firestore"));

        print("Previous file deleted");

        return true;
      } else {
        Fluttertoast.showToast(msg: "No avatar uploaded previously");

        return false;
      }
    } catch (e) {
      print("Error occured: ${e.toString()}");
      Fluttertoast.showToast(msg: e.toString());

      return false;
    }
  }
}
