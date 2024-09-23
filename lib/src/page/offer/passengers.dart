import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kongsi_kereta/src/model/user_model.dart';
import 'package:kongsi_kereta/src/widgets/list_tile/list_tile_profile.dart';

class OfferRidePassengers extends StatelessWidget {
  final UserModel driver; // Renamed to driver for clarity
  const OfferRidePassengers({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Passenger List"),
      ),
      body: ListView(
        children: [
          listTileProfile(context: context, user: driver, includeEdit: false),
          // You can add additional passenger details here if needed
        ],
      ),
    );
  }
}
