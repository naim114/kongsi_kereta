import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kongsi_kereta/src/model/user_model.dart';
import 'package:kongsi_kereta/src/services/helpers.dart';
import 'package:kongsi_kereta/src/widgets/list_tile/list_tile_profile.dart';

class FindRideDetails extends StatelessWidget {
  final UserModel user;
  const FindRideDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ride Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          // horizontal: 25,
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Perodua Bezza",
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "ABC 1234",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            listTileProfile(
              context: context,
              user: user,
              includeEdit: false,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10),
              child: Text(
                "Trip Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Status: ",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                "In Transit",
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              title: Text(
                "Fare: ",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                "RM5.00",
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              title: Text(
                "From: ",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                "Taman Maluri",
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              title: Text(
                "To: ",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: const Text(
                "UniKL MIIT",
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              title: Text(
                "Drop Off: ",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                "05:35PM",
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              title: Text(
                "Car Plate: ",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                "ABC 1234",
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              title: Text(
                "Car Model: ",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                "Perodua Bezza",
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              title: Text(
                "Passenger Number: ",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                "4",
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10),
              child: Text(
                "Driver Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Name: ",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                "Driver name here",
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              title: Text(
                "Email: ",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                "Driver email here",
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              title: Text(
                "Phone: ",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                "Driver phone here",
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Tap here to join ride",
                style: TextStyle(
                  color: CustomColor.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
