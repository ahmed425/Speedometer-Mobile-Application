import 'package:car_speedometer/providers/speedometer_provider.dart';
import 'package:car_speedometer/widgets/speedometer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => SpeedometerProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SpeedometerWidget(),
        theme: ThemeData(
            textTheme: TextTheme(
                bodyText1: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                bodyText2: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.green))),
      ),
    );
  }
}
