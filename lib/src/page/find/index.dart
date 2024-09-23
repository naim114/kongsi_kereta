import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kongsi_kereta/src/model/user_model.dart';
import 'package:kongsi_kereta/src/page/find/list.dart';
import 'package:kongsi_kereta/src/services/helpers.dart';
import 'package:kongsi_kereta/src/widgets/card/find_ride_card.dart';

import '../../widgets/button/custom_pill_button.dart';
import '../../widgets/typography/page_title_icon.dart';

class FindRide extends StatelessWidget {
  final BuildContext mainContext;
  final UserModel user;
  const FindRide({super.key, required this.mainContext, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                  title: "Search Ride",
                  icon: const Icon(
                    CupertinoIcons.search,
                    size: 20,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'View your ride or search for available ride here.',
                    style: TextStyle(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.045,
            child: GestureDetector(
              onTap: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
              child: TextField(
                readOnly: false,
                autofocus: false,
                enabled: false,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? CupertinoColors.darkBackgroundGray
                      : Colors.white,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: const BorderSide(
                      color: CupertinoColors.systemGrey,
                      width: 1,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search for available ride here',
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
              "My Ride",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          findRideCard(context: mainContext, user: user),
          SizedBox(height: 10),
          customPillButton(
            context: context,
            borderColor: CustomColor.primary,
            child: const Text(
              "View All Ride",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.push(
              mainContext,
              MaterialPageRoute(
                builder: (context) => FindRideViewAll(
                  user: user,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
