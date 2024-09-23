import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kongsi_kereta/src/model/user_model.dart';
import 'package:kongsi_kereta/src/model/ride_model.dart';
import 'package:kongsi_kereta/src/page/offer/details.dart';

import '../../services/helpers.dart';

Widget offerRideCard({
  required BuildContext context,
  required RideModel ride,
  required UserModel user,
}) =>
    GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OfferRideDetails(
            ride: ride,
            mainContext: context,
          ),
        ),
      ),
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Badge(
                label: Text('Full'),
                backgroundColor: CustomColor.secondary,
                child: Text(
                  ride.carPlate,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Text(ride.carModel),
            ),
            Divider(thickness: 0.5, color: Colors.grey),
            ListTile(
              title: Text(
                "From: ",
                style: TextStyle(fontSize: 15),
              ),
              subtitle: Text(
                ride.fromLocation,
                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
              ),
            ),
            Divider(thickness: 0.5, color: Colors.grey),
            ListTile(
              title: Text(
                "To: ",
                style: TextStyle(fontSize: 15),
              ),
              subtitle: Text(
                ride.toLocation,
                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
              ),
            ),
            Divider(thickness: 0.5, color: Colors.grey),
            ListTile(
              title: Text(
                "Drop Off: ",
                style: TextStyle(fontSize: 15),
              ),
              subtitle: Text(
                DateFormat('hh:mm a').format(ride.dropOffTime),
                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
