import 'package:app/screens/workout_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Fit',
      theme: ThemeData.dark(useMaterial3: true),
      home: const WorkoutList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
