import 'package:flutter/material.dart';
import 'screens/prize_wheel_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prize Wheel Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: PrizeWheelScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
