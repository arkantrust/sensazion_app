import 'package:flutter/material.dart';
import 'package:sensazion_app/src/app/theme.dart';
import 'package:sensazion_app/src/home/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SensazionApp',
      theme: lightTheme,
      home: HomePage(),
    );
  }
}
