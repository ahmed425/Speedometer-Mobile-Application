# car_speedometer

A car speedometer mobile app with Flutter to measure the current speed of the vehicle and measure the time the vehicle takes to speed up from 10 KMH to 30 KMH and the time the vehicle takes to slow down from 30 KMH to 10 KMH.

![Car Speedometer Demo](https://i.imgur.com/HW3rlfS.gif)

## Pattern/Approach Used 
The Provider pattern is used for data and state management .

## Flutter Packages/Plugins/Libraries Used

segment_display: ^0.4.1+1 :	To Support multiple types of segment displays.
geolocator: ^5.3.2+2	: To provide easy access to platform specific location services.

provider: ^4.1.3 :	For data and state management.

flutter_launcher_icons: ^0.7.5	: For creating app icon.

## This app was made using the provider Approach/Pattern as follows:

## Data Models: SpeedometerModel Class includes the following fields/variables:
                currrentSpeed (double): To represent the vehicle current speed
                time10_30 (int) : To represent the time in seconds the vehicle takes to speed up from 10 KM/H to 30 KM/H.
                time30_10 (int) : To represent the time in seconds the vehicle takes to slow down from 30 KM/H to 10 KM/H.
                type (int) : To represent the range of speed in which the vehicle is moving.
## Providers:SpeedometerProvider Class includes instance of SpeedometerModel and the following methods: 
checkLocationAndPermissionStatus() to check the location service and permission status, getSpeed() to get the vehicle current speed and checkSpeedAndMeasureTimeWhileInRange(double vehicleSpeed), checkSpeedAndMeasureTimeWhileOutOfRange(double vehicleSpeed) to measure time10_30 and time 30_10 .
## Widgets: SpeedometerWidget Class (StatelessWidget) which listens to the SpeedometerProvider Class to be notified of changes and update the UI accordingly and it includes the following :
-providerData : instance of the SpeedometerProvider class to listen to provider data changes.
