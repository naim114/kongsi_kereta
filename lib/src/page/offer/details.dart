import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kongsi_kereta/src/model/ride_model.dart';
import 'package:kongsi_kereta/src/page/offer/passengers.dart';
import 'package:kongsi_kereta/src/services/helpers.dart';
import 'package:kongsi_kereta/src/widgets/list_tile/list_tile_profile.dart';

class OfferRideDetails extends StatelessWidget {
  final RideModel ride;
  final BuildContext mainContext;

  const OfferRideDetails(
      {super.key, required this.ride, required this.mainContext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                ride.carModel,
                style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                ride.carPlate,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            listTileProfile(
                context: context, user: ride.driver!, includeEdit: false),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10),
              child: Text(
                "Trip Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            ListTile(
              title: Text("Status: ", style: TextStyle(fontSize: 15)),
              subtitle: Text("In Transit",
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
            ),
            Divider(thickness: 0.5, color: Colors.grey),
            ListTile(
              title: Text("Fare: ", style: TextStyle(fontSize: 15)),
              subtitle: Text("RM${ride.fare.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
            ),
            Divider(thickness: 0.5, color: Colors.grey),
            ListTile(
              title: Text("From: ", style: TextStyle(fontSize: 15)),
              subtitle: Text(ride.fromLocation,
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
            ),
            Divider(thickness: 0.5, color: Colors.grey),
            ListTile(
              title: Text("To: ", style: TextStyle(fontSize: 15)),
              subtitle: Text(ride.toLocation,
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
            ),
            Divider(thickness: 0.5, color: Colors.grey),
            ListTile(
              title: Text("Drop Off: ", style: TextStyle(fontSize: 15)),
              subtitle: Text(DateFormat('hh:mm a').format(ride.dropOffTime),
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
            ),
            Divider(thickness: 0.5, color: Colors.grey),
            ListTile(
              title: Text("Car Plate: ", style: TextStyle(fontSize: 15)),
              subtitle: Text(ride.carPlate,
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
            ),
            Divider(thickness: 0.5, color: Colors.grey),
            ListTile(
              title: Text("Car Model: ", style: TextStyle(fontSize: 15)),
              subtitle: Text(ride.carModel,
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
            ),
            Divider(thickness: 0.5, color: Colors.grey),
            ListTile(
              title: Text("Passenger Number: ", style: TextStyle(fontSize: 15)),
              subtitle: Text(ride.passengerNumber.toString(),
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
            ),
            Divider(thickness: 0.5, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10),
              child: Text("Driver Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ),
            listTileProfile(
                context: context, user: ride.driver!, includeEdit: false),
            Divider(thickness: 0.5, color: Colors.grey),
            TextButton(
              onPressed: () => Navigator.push(
                mainContext,
                MaterialPageRoute(
                  builder: (context) =>
                      OfferRidePassengers(driver: ride.driver!),
                ),
              ),
              child: Text("Tap here to view passengers",
                  style: TextStyle(
                      color: CustomColor.success, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
