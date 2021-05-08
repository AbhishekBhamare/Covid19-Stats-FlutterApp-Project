import 'package:flutter/material.dart';
import 'Home.dart';
import 'app.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/': (context) => Home(),
    '/myapp': (context) => MyApp(),
  },
));
