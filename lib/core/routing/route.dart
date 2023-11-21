import 'package:flutter/material.dart';
import '../../main.dart';

push(Widget child) => Navigator.of(navigatorKey.currentContext!)
    .push(MaterialPageRoute(builder: (context) => child));

pushAndRemoveUntil(Widget child) =>
    Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => child), (route) => false);

pushReplacement(Widget child) => Navigator.of(navigatorKey.currentContext!)
    .pushReplacement(MaterialPageRoute(builder: (context) => child));
