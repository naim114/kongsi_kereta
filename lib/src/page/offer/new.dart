import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/helpers.dart';
import '../../widgets/button/custom_pill_button.dart';
import '../../model/user_model.dart';
import '../../services/ride_services.dart';

class NewOffer extends StatefulWidget {
  const NewOffer({super.key, required this.currentUser});

  final UserModel currentUser;

  @override
  _NewOfferState createState() => _NewOfferState();
}

class _NewOfferState extends State<NewOffer> {
  final TextEditingController fareController = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController dropOffController = TextEditingController();
  final TextEditingController carPlateController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController passengerNumberController =
      TextEditingController();

  @override
  void dispose() {
    fareController.dispose();
    fromController.dispose();
    toController.dispose();
    dropOffController.dispose();
    carPlateController.dispose();
    carModelController.dispose();
    passengerNumberController.dispose();
    super.dispose();
  }

  Future<void> sendRideOffer() async {
    if (fareController.text.isEmpty ||
        fromController.text.isEmpty ||
        toController.text.isEmpty ||
        dropOffController.text.isEmpty ||
        carPlateController.text.isEmpty ||
        carModelController.text.isEmpty ||
        passengerNumberController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill in all fields");
      return;
    }

    Fluttertoast.showToast(msg: "Sending ride offer");

    DateTime dropOffTime = DateFormat('hh:mm a').parse(dropOffController.text);

    dynamic add = await RideServices().add(
      driver: widget.currentUser,
      fare: double.parse(fareController.text),
      fromLocation: fromController.text,
      toLocation: toController.text,
      dropOffTime: dropOffTime,
      carPlate: carPlateController.text,
      carModel: carModelController.text,
      passengerNumber: int.parse(passengerNumberController.text),
    );

    if (add == true && context.mounted) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Ride offer sent");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Trip"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: fareController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      decoration: const InputDecoration(labelText: 'Fare (RM)'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: fromController,
                      decoration: const InputDecoration(labelText: 'From'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: toController,
                      decoration: const InputDecoration(labelText: 'To'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: dropOffController,
                      readOnly: true,
                      decoration:
                          const InputDecoration(labelText: 'Drop Off Time'),
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          final now = DateTime.now();
                          final pickedDateTime = DateTime(
                            now.year,
                            now.month,
                            now.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                          String formattedTime =
                              DateFormat('hh:mm a').format(pickedDateTime);
                          setState(() {
                            dropOffController.text = formattedTime;
                          });
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: carPlateController,
                      decoration: const InputDecoration(labelText: 'Car Plate'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: carModelController,
                      decoration: const InputDecoration(labelText: 'Car Model'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: passengerNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration:
                          const InputDecoration(labelText: 'Passenger Number'),
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
                      "Confirm Trip",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: sendRideOffer,
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
