import 'package:car_speedometer/util/utils_methods.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/speedometer_model.dart';
import 'package:location/location.dart' hide LocationAccuracy;

class SpeedometerProvider with ChangeNotifier {
  Speedometer _speedometer =
      new Speedometer(currentSpeed: 0, time10_30: 0, time30_10: 0);

  Speedometer get speedometer => _speedometer;
  Stopwatch _stopwatch = Stopwatch();
  final Geolocator _geolocator = Geolocator();

  //Method to check location service status and location permission status
  Future<bool> checkLocationServiceAndPermissionStatus() async {
    Location location = new Location();
    bool _isLocationServiceEnabled;
    PermissionStatus _permissionGranted;
    _isLocationServiceEnabled = await location.serviceEnabled();
    if (!_isLocationServiceEnabled) {
      _isLocationServiceEnabled = await location.requestService();
      if (!_isLocationServiceEnabled) {
        showError(
            "Car Speedometer require enabling the location service to be able to measure the vehicle speed");
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        showError(
            "Car Speedometer requires the location permission to be able to measure the vehicle speed");
      }
    }
    return _isLocationServiceEnabled &&
        _permissionGranted == PermissionStatus.granted;
  }

  void updateSpeed(Position position) {
    double speed = position.speed;
    _speedometer.currentSpeed = speed;

    if (speed >= SPEED_10 || speed <= SPEED_30) {
      checkSpeedAndMeasureTimeWhileInRange(speed);
    }
    if (speed < SPEED_10 || speed > SPEED_30) {
      checkSpeedAndMeasureTimeWhileOutOfRange(speed);
    }
    print("current speed is : " + speed.toString());
    print("time10_30 is : " + speedometer.time10_30.toString());
    print("time30_10 is : " + speedometer.time30_10.toString());

    notifyListeners();
  }

  //Method to get the vehicle current speed
  getSpeedUpdates() async {
    if (await checkLocationServiceAndPermissionStatus()) {
      LocationOptions options =
          LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
      _geolocator.getPositionStream(options).listen((position) {
        updateSpeed(position);
      });
    }
  }

  void checkSpeedAndMeasureTimeWhileInRange(double vehicleSpeed) {
    if (vehicleSpeed >= SPEED_10) {
      //check if the vehicle speed was less than 10 KMH

      if (speedometer.type == LESS_10) {
        speedometer.type = FROM_10_TO_30;
        _stopwatch.start();
        speedometer.time10_30 = _stopwatch.elapsed.inSeconds;
      }
      //check if the vehicle speed was in the range from 10 to 30
      else if (speedometer.type == FROM_10_TO_30) {
        //update the time on the screen accordingly (time10_30)
        speedometer.time10_30 = _stopwatch.elapsed.inSeconds;
      }
    }

    if (vehicleSpeed <= SPEED_30) {
      if (speedometer.type == OVER_30) {
        speedometer.type = FROM_30_TO_10;
        _stopwatch.start();
        speedometer.time30_10 = _stopwatch.elapsed.inSeconds;
      } else if (speedometer.type == FROM_30_TO_10) {
        speedometer.time30_10 = _stopwatch.elapsed.inSeconds;
      }
    }
  }

  void checkSpeedAndMeasureTimeWhileOutOfRange(double vehicleSpeed) {
    //check if the vehicle speed is less than 10 KMH
    if (vehicleSpeed < SPEED_10) {
      //check if the vehicle speed was in the range from 30_10 KMH
      if (speedometer.type == FROM_30_TO_10) {
        //convert the type to LESS_10
        speedometer.type = LESS_10;
        //Stop the stopwatch
        _stopwatch.stop();
        //update the time on the screen accordingly (time10_30)
        speedometer.time30_10 = _stopwatch.elapsed.inSeconds;
        //Reset the Stopwatch because the vehicle speed is (LESS_10) out of range
        _stopwatch.reset();
      }
      //check if the vehicle speed was in the range from 10_30 KMH
      else if (speedometer.type == FROM_10_TO_30) {
        //convert the range to LESS_10
        speedometer.type = LESS_10;
        //Reset the Stopwatch because the vehicle speed is (LESS_10) out of range
        _stopwatch.reset();
        //Update the time10_30 on the screen with Zero to start the time (time10_30) again from the beginning
        speedometer.time10_30 = _stopwatch.elapsed.inSeconds;
      }
    }

    //check if the vehicle speed is more than 30 KMH
    if (vehicleSpeed > SPEED_30) {
      //check if the vehicle speed was in the range from 10_30 KMH
      if (speedometer.type == FROM_10_TO_30) {
        //convert the type to OVER_30
        speedometer.type = OVER_30;
        //Stop the stopwatch
        _stopwatch.stop();
        //update the time on the screen accordingly (time10_30)
        speedometer.time10_30 = _stopwatch.elapsed.inSeconds;
        //Reset the Stopwatch because the vehicle speed is (OVER_30) out of range
        _stopwatch.reset();
      }
      //check if the vehicle speed was in the range from 30_10 KMH
      else if (speedometer.type == FROM_30_TO_10) {
        //convert the range to OVER_30
        speedometer.type = OVER_30;
        //Reset the Stopwatch because the vehicle speed is (OVER_30) out of range
        _stopwatch.reset();
        //Update the time30_10 on the screen with Zero to start the time (time30_10) again from the beginning
        speedometer.time30_10 = _stopwatch.elapsed.inSeconds;
      }
    }
  }
}
