import 'package:app/models/workout_model.dart';
import 'package:app/screens/workout_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final model = WorkoutModel();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WorkoutModel>.value(value: model)
        //
      ],
      child: MaterialApp(
        title: 'Magic Fit',
        theme: ThemeData.dark(useMaterial3: true),
        home: const WorkoutList(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
