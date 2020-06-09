//import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
//import '../models/speedometer_model.dart';
//import 'package:location/location.dart' as carLocation;
//
//class SpeedometerProvider with ChangeNotifier {
//  Speedometer _speedometer =
//      new Speedometer(currentSpeed: 0, time10_30: 0, time30_10: 0);
//
//  Speedometer get speedometer => _speedometer;
//  bool _serviceEnabled;
//  carLocation.PermissionStatus _permissionGranted;
//  Future<void> checkLocationPermission() async {
//    carLocation.Location location = new carLocation.Location();
//
//    _serviceEnabled = await location.serviceEnabled();
//    if (!_serviceEnabled) {
//      _serviceEnabled = await location.requestService();
//    }
//    _permissionGranted = await location.hasPermission();
//    if (_permissionGranted == carLocation.PermissionStatus.denied) {
//      _permissionGranted = await location.requestPermission();
//    }
//    if (_serviceEnabled == true &&
//        _permissionGranted == carLocation.PermissionStatus.granted) {};
//  }
//
//  Future<void> getSpeed() async {
//
//    final Geolocator geolocator = Geolocator();
//      LocationOptions options =
//          LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
//      geolocator.getPositionStream(options).listen((position) {
//        double speed = position.speed;
//        _speedometer.currentSpeed = speed;
//        checkSpeedAndCalcTime(speed);
//
//        print("current speed is : " + speed.toString());
//        print("time10_30 is : " + speedometer.time10_30.toString());
//        print("time30_10 is : " + speedometer.time30_10.toString());
//
//        notifyListeners();
//      });
//    }
//  }
//
//  //Method to Calculate the time the vehicle takes to speed up from 10 KM/H to 30 KM/H and The time it takes to slow down from 30 KM/H to 10 KM/H
//  void checkSpeedAndCalcTime(double currentSpeed) {
//    //Stopwatch to measure the time from 10 to 30 KM/H
//    Stopwatch stopwatch10_30 = Stopwatch();
//    //Stopwatch to measure the time from 10 to 30 KM/H
//    Stopwatch stopwatch30_10 = Stopwatch();
//    if (currentSpeed == 10) {
//      //start stopwatch10_30
//      stopwatch10_30.start();
////Check if stopwatch30_10 is running or not and stop it if it is already running and set the value of time30_10 to be dispalyed on the screen
//      if (stopwatch30_10.isRunning) {
//        stopwatch30_10.stop();
//        _speedometer.time30_10 = stopwatch30_10.elapsed.inSeconds
//      }
//    }
//    if (currentSpeed == 30) {
//      //start stopwatch30_10
//      stopwatch30_10.start();
//      //Check if stopwatch10_30 is running or not and stop it if it is already running and set the value of time10_30 to be dispalyed on the screen
//      if (stopwatch10_30.isRunning) {
//        stopwatch10_30.stop();
//        _speedometer.time10_30 = stopwatch10_30.elapsed.inSeconds;
//      }
//    }
//  }
//}
