import 'package:flutter/foundation.dart';

class Speedometer {
  double currentSpeed;
  int time10_30;
  int time30_10;
  int type;

  Speedometer(
      {@required this.currentSpeed,
      @required this.time10_30,
      @required this.time30_10,
      this.type = LESS_10});
}

const FROM_10_TO_30 = 1;
const FROM_30_TO_10 = 2;
const LESS_10 = 0;
const OVER_30 = 3;
const SPEED_10 = 10;
const SPEED_30 = 30;
