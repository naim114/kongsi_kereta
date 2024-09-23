import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kongsi_kereta/src/page/offer/new.dart';
import 'package:kongsi_kereta/src/services/ride_services.dart';
import 'package:kongsi_kereta/src/widgets/card/offer_ride_card.dart';
import '../../model/ride_model.dart';
import '../../model/user_model.dart';
import '../../services/helpers.dart';
import '../../widgets/button/custom_pill_button.dart';
import '../../widgets/typography/page_title_icon.dart';
import 'list.dart';

class OfferRide extends StatefulWidget {
  final BuildContext mainContext;
  final UserModel user;

  const OfferRide({super.key, required this.mainContext, required this.user});

  @override
  _OfferRideState createState() => _OfferRideState();
}

class _OfferRideState extends State<OfferRide> {
  RideModel? latestRide; // Store the latest ride

  @override
  void initState() {
    super.initState();
    fetchLatestRide(); // Fetch the latest ride when the widget initializes
  }

  Future<void> fetchLatestRide() async {
    RideServices rideService = RideServices();
    latestRide = await rideService.getLatestRideByDriver(widget.user.id);
    setState(() {}); // Update the UI after fetching
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
      ),
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 25,
            bottom: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pageTitleIcon(
                context: context,
                title: "Offer Ride",
                icon: const Icon(
                  CupertinoIcons.car_detailed,
                  size: 20,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Make a trip and earn money!',
                  style: TextStyle(),
                ),
              ),
            ],
          ),
        ),
        customPillButton(
          context: context,
          borderColor: CustomColor.primary,
          child: const Text(
            "Make a new trip",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => Navigator.push(
            widget.mainContext,
            MaterialPageRoute(
              builder: (context) => NewOffer(
                currentUser: widget.user,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 20,
            bottom: 20,
          ),
          child: Text(
            "My Trip",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Pass the latest ride to offerRideCard
        if (latestRide != null)
          offerRideCard(
              context: widget.mainContext,
              user: widget.user,
              ride: latestRide!),
        SizedBox(height: 10),
        customPillButton(
          context: context,
          borderColor: CustomColor.primary,
          child: const Text(
            "View All Trip",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => Navigator.push(
            widget.mainContext,
            MaterialPageRoute(
              builder: (context) => OfferRideViewAll(
                user: widget.user,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
