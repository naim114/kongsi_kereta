import 'package:kongsi_kereta/src/model/user_model.dart';

class RideModel {
  final String id;
  final UserModel? driver;
  final double fare;
  final String fromLocation;
  final String toLocation;
  final DateTime dropOffTime;
  final String carPlate;
  final String carModel;
  final int passengerNumber;
  final List<UserModel>? passengers; // Nullable list of passengers
  final DateTime createdAt;
  final DateTime updatedAt;

  RideModel({
    required this.id,
    required this.driver,
    required this.fare,
    required this.fromLocation,
    required this.toLocation,
    required this.dropOffTime,
    required this.carPlate,
    required this.carModel,
    required this.passengerNumber,
    this.passengers, // Nullable
    required this.createdAt,
    required this.updatedAt,
  });

  RideModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        driver = json['driver'],
        fare = json['fare'],
        fromLocation = json['fromLocation'],
        toLocation = json['toLocation'],
        dropOffTime = DateTime.parse(json['dropOffTime']),
        carPlate = json['carPlate'],
        carModel = json['carModel'],
        passengerNumber = json['passengerNumber'],
        passengers = (json['passengers'] as List<dynamic>?)
            ?.map((item) => UserModel.fromJson(item))
            .toList(), // Handle nullable
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'driver': driver!.id,
      'fare': fare,
      'fromLocation': fromLocation,
      'toLocation': toLocation,
      'dropOffTime': dropOffTime.toIso8601String(),
      'carPlate': carPlate,
      'carModel': carModel,
      'passengerNumber': passengerNumber,
      'passengers':
          passengers?.map((p) => p.toJson()).toList(), // Handle nullable
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'RideModel(id: $id, driver: $driver, fare: $fare, fromLocation: $fromLocation, toLocation: $toLocation, dropOffTime: $dropOffTime, carPlate: $carPlate, carModel: $carModel, passengerNumber: $passengerNumber, passengers: $passengers, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
