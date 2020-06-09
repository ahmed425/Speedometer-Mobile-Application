//import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
//import '../models/speedometer_model.dart';
//
//class SpeedometerProvider with ChangeNotifier {
//  Speedometer _speedometer = new Speedometer(currentSpeed: 0, time10_30: 0, time30_10: 0);
//  Speedometer get speedometer => _speedometer;
//
//  Stopwatch stopwatch = Stopwatch();
//  //Method to get the vehicle current speed
//  Future<void> getSpeed() async {
//    final Geolocator geolocator = Geolocator();
//    LocationOptions options =
//        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
//    geolocator.getPositionStream(options).listen((position) {
//      double speed = position.speed;
//      _speedometer.currentSpeed = speed;
//      checkSpeedAndMeasureTime(speed);
//
//      print("current speed is : " + speed.toString());
//      print("time10_30 is : " + speedometer.time10_30.toString());
//      print("time30_10 is : " + speedometer.time30_10.toString());
//
//      notifyListeners();
//    });
//  }
//
//  //Method to Measure the time the vehicle takes to speed up from 10 KM/H to 30 KM/H and The time it takes to slow down from 30 KM/H to 10 KM/H
//  void checkSpeedAndMeasureTime(double vehicleSpeed) {
//    if(vehicleSpeed >= 10){
//      if(speedometer.type == LESS_10){
//        speedometer.type = FROM_10_TO_30;
//        stopwatch.start();
//        speedometer.time10_30 = stopwatch.elapsed.inSeconds;
//      } else if(speedometer.type == FROM_10_TO_30){
//        speedometer.time10_30 = stopwatch.elapsed.inSeconds;
//      }
//    }
//    if(vehicleSpeed >= 20){
//      if(speedometer.type == FROM_10_TO_30){
//        speedometer.type = OVER_30;
//        stopwatch.stop();
//        speedometer.time10_30 = stopwatch.elapsed.inSeconds;
//        stopwatch.reset();
//      }else if(speedometer.type == FROM_30_TO_10){
//        speedometer.type = OVER_30;
//        stopwatch.reset();
//        speedometer.time30_10 = stopwatch.elapsed.inSeconds;
//      }
//
//    }
//
//    if(vehicleSpeed <= 20){
//      if(speedometer.type == OVER_30){
//        speedometer.type = FROM_30_TO_10;
//        stopwatch.start();
//        speedometer.time30_10 = stopwatch.elapsed.inSeconds;
//      } else if(speedometer.type == FROM_30_TO_10){
//        speedometer.time30_10 = stopwatch.elapsed.inSeconds;
//      }
//    }
//    if(vehicleSpeed <= 10){
//      if(speedometer.type == FROM_30_TO_10){
//        speedometer.type = LESS_10;
//        stopwatch.stop();
//        speedometer.time30_10 = stopwatch.elapsed.inSeconds;
//        stopwatch.reset();
//      } else if(speedometer.type == FROM_10_TO_30){
//        speedometer.type = LESS_10;
//        stopwatch.reset();
//        speedometer.time10_30 = stopwatch.elapsed.inSeconds;
//      }
//    }
//  }
//}
