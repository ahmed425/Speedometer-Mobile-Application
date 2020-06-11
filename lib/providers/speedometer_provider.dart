import 'package:car_speedometer/utils/utils_methods.dart';
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
        showErrorToast(
            "Car Speedometer require enabling the location service to be able to measure the vehicle speed");
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        showErrorToast(
            "Car Speedometer requires the location permission to be able to measure the vehicle speed");
      }
    }
    return _isLocationServiceEnabled &&
        _permissionGranted == PermissionStatus.granted;
  }

//Method to update the current speed according to the vehicle position
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

  //Method to get the vehicle speed updates
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
      if (speedometer.range == LESS_10) {
        speedometer.range = FROM_10_TO_30;
        _stopwatch.start();
        speedometer.time10_30 = _stopwatch.elapsed.inSeconds;
      }
      //check if the vehicle speed was in the range from 10 to 30
      else if (speedometer.range == FROM_10_TO_30) {
        //update the time on the screen accordingly (time10_30)
        speedometer.time10_30 = _stopwatch.elapsed.inSeconds;
      }
    }

    if (vehicleSpeed <= SPEED_30) {
      //check if the vehicle speed was more than 30 KMH
      if (speedometer.range == OVER_30) {
        speedometer.range = FROM_30_TO_10;
        _stopwatch.start();
        speedometer.time30_10 = _stopwatch.elapsed.inSeconds;
        //check if the vehicle speed from 30 to 10
      } else if (speedometer.range == FROM_30_TO_10) {
        speedometer.time30_10 = _stopwatch.elapsed.inSeconds;
      }
    }
  }

  void checkSpeedAndMeasureTimeWhileOutOfRange(double vehicleSpeed) {
    //check if the vehicle speed is less than 10 KMH
    if (vehicleSpeed < SPEED_10) {
      //check if the vehicle speed was in the range from 30_10 KMH
      if (speedometer.range == FROM_30_TO_10) {
        speedometer.range = LESS_10;
        _stopwatch.stop();
        //update the time on the screen accordingly (time10_30)
        speedometer.time30_10 = _stopwatch.elapsed.inSeconds;
        _stopwatch.reset();
      }
      //check if the vehicle speed was in the range from 10 to 30
      else if (speedometer.range == FROM_10_TO_30) {
        speedometer.range = LESS_10;
        //reset the stopwatch since the vehicle speed is Less than 10 KMH (Out Of ange)
        _stopwatch.reset();
        speedometer.time10_30 = _stopwatch.elapsed.inSeconds;
      }
    }

    //check if the vehicle speed is more than 30 KMH
    if (vehicleSpeed > SPEED_30) {
      //check if the vehicle speed was in the range from 10_30 KMH
      if (speedometer.range == FROM_10_TO_30) {
        speedometer.range = OVER_30;
        _stopwatch.stop();
        //update the time on the screen accordingly (time10_30)
        speedometer.time10_30 = _stopwatch.elapsed.inSeconds;
        //reset the stopwatch since the vehicle speed is more than 30 KMH (Out Of ange)
        _stopwatch.reset();
      }
      //check if the vehicle speed was in the range from 30_10 KMH
      else if (speedometer.range == FROM_30_TO_10) {
        speedometer.range = OVER_30;
        //reset the stopwatch since the vehicle speed is more than 30 KMH (Out Of ange)
        _stopwatch.reset();
        speedometer.time30_10 = _stopwatch.elapsed.inSeconds;
      }
    }
  }
}
