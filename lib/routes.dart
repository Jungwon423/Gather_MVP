import 'package:flutter/material.dart';
import 'package:gather_mvp/ChatPages/InAirplane.dart';
import 'package:gather_mvp/ChatPages/bluebottle.dart';
import 'package:gather_mvp/ChatPages/hotel.dart';
import 'package:gather_mvp/ChatPages/restaurant.dart';
import 'package:gather_mvp/ChatPages/starbucks.dart';
import 'package:gather_mvp/HomePage.dart';

import 'ChatPages/ask_cafe.dart';
import 'ChatPages/ask_for_number.dart';
import 'ChatPages/bus_station.dart';
import 'ChatPages/foodtruck_hotdog.dart';
import 'ChatPages/foodtruck_icecream.dart';
import 'ChatPages/immigration.dart';
import 'ChatPages/taxi.dart';

final Map<String, WidgetBuilder> route = {
  "/home": (context) => HomePage(),
  '/inAirplane': (context) => InAirplane(),
  '/immigration': (context) => Immigration(),
  '/hotel': (context) => Hotel(),
  '/restaurant': (context) => Restaurant(),
  '/number' : (context) => AskForNumber(),
  '/taxi': (context) => Taxi(),
  '/hotdog' : (context) => FoodtruckHotdog(),
  '/icecream' : (context) => FoodTruckIceCream(),
  '/bus' : (context) => BusStation(),
  '/askCafe' : (context) => AskCafe(),
  '/starbucks' : (context) => Starbucks(),
  '/bluebottle' : (context) => Bluebottle()
};
