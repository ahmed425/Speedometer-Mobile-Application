# Speedometer Mobile App with Flutter

## Description
A car speedometer mobile app with Flutter to measure the current speed of the vehicle and measure the time the vehicle takes to speed up from 10 KMH to 30 KMH and the time the vehicle takes to slow down from 30 KMH to 10 KMH.

## Demo
![Car Speedometer Demo](https://i.imgur.com/K0cV2M6.gif) 

## Pattern/Approach Used 
The Provider pattern is used for data and state management .

## Flutter Packages/Plugins/Libraries Used

- segment_display: ^0.4.1+1 :	To Support multiple types of segment displays.
- geolocator: ^5.3.2+2	: To provide easy access to platform specific location services.
- location: ^3.0.2  : This plugin for Flutter handles getting location on Android and iOS.
- provider: ^4.1.3 :	For data and state management.
- flutter_launcher_icons: ^0.7.5	: For creating app icon.

## This app was made using the provider Approach/Pattern as follows:

### Data Models: SpeedometerModel Class includes the following fields/variables:
- currrentSpeed (double): To represent the vehicle current speed.
- time10_30 (int) : To represent the time in seconds the vehicle takes to speed up from 10 KM/H to 30 KM/H.
- time30_10 (int) : To represent the time in seconds the vehicle takes to slow down from 30 KM/H to 10 KM/H.
- range (int) : to represent the speed range in which the vehicle moving. 
### Providers:SpeedometerProvider Class includes instance of SpeedometerModel and the following methods: 
- checkLocationAndPermissionStatus() to check the location service and permission status.
- updateSpeed(Position position): which updates the vehicle current speed and call either checkSpeedAndMeasureTimeWhileInRange or checkSpeedAndMeasureTimeWhileOutOfRange according to the vehicle current speed.
- getSpeedUpdates() : which listens to the vehicle position and pass it to the updateSpeed(Position position) method . 
- checkSpeedAndMeasureTimeWhileInRange(double vehicleSpeed), checkSpeedAndMeasureTimeWhileOutOfRange(double vehicleSpeed): to measure time10_30 and time 30_10.
### Utils:
Includes utils method showErrorToast which shows Toast to user if he disabled or denied the location service or permission.  
### Widgets: SpeedometerWidget Class (StatelessWidget) which listens to the SpeedometerProvider Class to be notified of changes and update the UI accordingly and it includes the following :
- providerData : instance of the SpeedometerProvider class to listen to provider data changes.
![Widget_Tree](https://i.imgur.com/N9HCru0.png)

## How to run
- Clone this repo
- Run flutter packages get
- Run flutter run while connecting a physical mobile device or emulator
## APK file download link
- https://drive.google.com/file/d/1gMfwR89SaR6GJiZmlPBrlL69oEoDHhO7/view?usp=sharing
