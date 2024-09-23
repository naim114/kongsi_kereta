import 'package:flutter/material.dart';
import 'package:kongsi_kereta/src/model/user_model.dart';
import 'package:kongsi_kereta/src/page/find/details.dart';

import '../../services/helpers.dart';

Widget findRideCard({
  required BuildContext context,
  required UserModel user,
}) =>
    GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FindRideDetails(
            user: user,
          ),
        ),
      ),
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Badge(
                label: Text('Available'),
                backgroundColor: CustomColor.success,
                child: Text(
                  "ABC 1234",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Text("Perodua Bezza"),
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
          ],
        ),
      ),
    );
