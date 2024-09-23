import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kongsi_kereta/src/model/user_model.dart';
import 'package:kongsi_kereta/src/widgets/card/find_ride_card.dart';

class FindRideViewAll extends StatelessWidget {
  final UserModel user;
  const FindRideViewAll({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View All Ride"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: ListView(
          children: [findRideCard(context: context, user: user)],
        ),
      ),
    );
  }
}
