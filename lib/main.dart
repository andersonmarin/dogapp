import 'package:flutter/material.dart';
import 'package:smartmei_app/screens/breeds_list.dart';

void main() => runApp(SmartMEIApp());

class SmartMEIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.grey,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.green,
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        title: 'SmartMEI Dogs',
        home: BreedsList());
  }
}
