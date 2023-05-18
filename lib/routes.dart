import 'dart:js';

import 'package:flutter/material.dart';
import 'package:gather_mvp/ChatPages/Cafe.dart';
import 'package:gather_mvp/HomePage.dart';

final Map<String, WidgetBuilder> route = {
  "/home" : (context) => HomePage(),
  '/cafe' : (context) => Cafe()

};