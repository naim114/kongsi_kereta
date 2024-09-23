import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/ride_model.dart';
import '../model/user_model.dart';

class RideServices {
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('Ride');

  Future add({
    required UserModel driver,
    required double fare,
    required String fromLocation,
    required String toLocation,
    required DateTime dropOffTime,
    required String carPlate,
    required String carModel,
    required int passengerNumber,
    List<UserModel>? passengers, // Nullable
  }) async {
    try {
      dynamic add = await _collectionRef.add({
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      }).then((docRef) async {
        await _collectionRef.doc(docRef.id).set(RideModel(
              id: docRef.id,
              driver: driver,
              fare: fare,
              fromLocation: fromLocation,
              toLocation: toLocation,
              dropOffTime: dropOffTime,
              carPlate: carPlate,
              carModel: carModel,
              passengerNumber: passengerNumber,
              passengers: passengers,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ).toJson());
        print("Ride Added");
      });

      return true;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

  Future<RideModel?> getLatestRideByDriver(String driverId) async {
    try {
      QuerySnapshot querySnapshot = await _collectionRef
          .where('driver', isEqualTo: driverId)
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return RideModel.fromJson(
            querySnapshot.docs.first.data() as Map<String, dynamic>);
      }
      return null; // No ride found
    } catch (e) {
      print(e.toString());
      return null; // Handle errors as needed
    }
  }
}
