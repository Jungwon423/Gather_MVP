import 'package:flutter/material.dart';
import 'package:gather_mvp/ChatPages/InAirplane.dart';
import 'package:gather_mvp/ChatPages/hotel.dart';
import 'package:gather_mvp/ChatPages/restaurant.dart';
import 'package:gather_mvp/HomePage.dart';

import 'ChatPages/immigration.dart';

final Map<String, WidgetBuilder> route = {
  "/home": (context) => HomePage(),
  '/inAirplane': (context) => InAirplane(),
  '/immigration': (context) => Immigration(),
  '/hotel': (context) => BlueBottle(),
  '/restaurant': (context) => Restaurant()
};
