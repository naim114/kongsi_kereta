import 'package:cached_network_image/cached_network_image.dart';
import 'package:country/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:kongsi_kereta/src/widgets/button/custom_pill_button.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/user_model.dart';
import '../../services/auth_services.dart';
import '../../services/helpers.dart';
import '../../services/user_services.dart';
import '../../widgets/editor/image_uploader.dart';

class Account extends StatefulWidget {
  const Account({super.key, required this.mainContext, required this.user});

  final BuildContext mainContext;
  final UserModel user;

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final AuthService _authService = AuthService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  String countryDropdownValue = Countries.mys.number;

  @override
  void initState() {
    nameController.text = widget.user.name;
    phoneController.text = widget.user.phone ?? "";
    addressController.text = widget.user.address ?? "";
    bioController.text = widget.user.bio ?? "";
    birthdayController.text = widget.user.birthday != null
        ? DateFormat('dd/MM/yyyy')
            .format(widget.user.birthday ?? DateTime.now())
        : "";

    countryDropdownValue = widget.user.country.number;

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    birthdayController.dispose();
    addressController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              _authService.signOut(widget.user);
            },
            icon: const Icon(
              Icons.logout,
              color: CustomColor.danger,
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            color: getColorByBackground(context),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Choose an action'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.image_outlined),
                          title: const Text('New avatar'),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ImageUploader(
                                appBarTitle: "Upload New Avatar",
                                onCancel: () => Navigator.of(context).pop(),
                                onConfirm: (imageFile, uploaderContext) async {
                                  print("Image file: ${imageFile.toString()}");

                                  Fluttertoast.showToast(
                                    msg: "Uploading new avatar. Please wait.",
                                  );

                                  // Close dialogs
                                  Navigator.pop(context); // Close dialog

                                  final result =
                                      await UserServices().updateAvatar(
                                    imageFile: imageFile,
                                    user: widget.user,
                                  );

                                  print("Update Avatar: ${result.toString()}");

                                  if (result == true) {
                                    Fluttertoast.showToast(
                                      msg:
                                          "Avatar Updated. Please refresh to see changes.",
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.delete_outline,
                            color: CustomColor.danger,
                          ),
                          title: const Text(
                            'Remove current picture',
                            style: TextStyle(color: CustomColor.danger),
                          ),
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                  'Are you sure you want to remove your avatar?'),
                              content: const Text(
                                'Deleted data can\'t be retrieved back. Select OK to proceed.',
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: CupertinoColors.systemGrey,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // Close dialogs
                                    Navigator.pop(
                                        context); // Close confirmation dialog
                                    Navigator.pop(context); // Close main dialog

                                    final result =
                                        await UserServices().removeAvatar(
                                      user: widget.user,
                                    );

                                    print(
                                        "Remove Avatar: ${result.toString()}");

                                    if (result == true) {
                                      Fluttertoast.showToast(
                                        msg:
                                            "Avatar Removed. Please refresh to see changes.",
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(color: CustomColor.danger),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.height * 0.17,
                    child: widget.user.avatarURL == null
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.17,
                            width: MediaQuery.of(context).size.height * 0.17,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/default-profile-picture.png'),
                                  fit: BoxFit.cover),
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: widget.user.avatarURL!,
                            //  'https://sunnycrew.jp/wp-content/themes/dp-colors/img/post_thumbnail/noimage.png',
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) => Container(
                              height: MediaQuery.of(context).size.height * 0.17,
                              width: MediaQuery.of(context).size.height * 0.17,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: CupertinoColors.systemGrey,
                              highlightColor: CupertinoColors.systemGrey2,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                width:
                                    MediaQuery.of(context).size.height * 0.17,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: MediaQuery.of(context).size.height * 0.17,
                              width: MediaQuery.of(context).size.height * 0.17,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/default-profile-picture.png'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Edit Avatar',
                      style: TextStyle(
                        color: CustomColor.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  // Name
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                  ),
                  // Bio
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: bioController,
                      decoration: const InputDecoration(labelText: 'Bio'),
                    ),
                  ),
                  // Birthday
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: birthdayController,
                      readOnly: true,
                      decoration: const InputDecoration(labelText: 'Birthday'),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now());

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                          setState(
                              () => birthdayController.text = formattedDate);
                        } else {
                          setState(() => birthdayController.text =
                              DateFormat('dd/MM/yyyy').format(DateTime.now()));
                        }
                      },
                    ),
                  ),
                  // Phone Number
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: phoneController,
                      decoration:
                          const InputDecoration(labelText: 'Phone Number'),
                    ),
                  ),
                  // Address
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                    ),
                  ),
                  // Country
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      elevation: 0,
                      value: countryDropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      decoration: const InputDecoration(labelText: 'Country'),
                      onChanged: (String? value) {
                        print(value);
                        setState(() => countryDropdownValue = value!);
                      },
                      items: Countries.values.map<DropdownMenuItem<String>>(
                        (Country country) {
                          return DropdownMenuItem<String>(
                            value: country.number,
                            child: Text(
                              country.isoShortName,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(),
                  ),
                  customPillButton(
                    context: context,
                    borderColor: CustomColor.primary,
                    child: const Text(
                      "Update Profile Details",
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      dynamic result = await UserServices().updateDetails(
                        user: widget.user,
                        name: nameController.text,
                        birthday: birthdayController.text == ""
                            ? null
                            : DateFormat('dd/MM/yyyy')
                                .parse(birthdayController.text),
                        phone: phoneController.text,
                        bio: bioController.text,
                        address: addressController.text,
                        countryNumber: countryDropdownValue,
                      );

                      Fluttertoast.showToast(
                          msg: "Details sucessfully updated.");
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
