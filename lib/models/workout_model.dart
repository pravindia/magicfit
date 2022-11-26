import 'dart:convert';

import 'package:localstorage/localstorage.dart';

import '../config/constants.dart';
import '../config/mock_data.dart';
import './serializers/workout.dart';
import './serializers/workout_set.dart';

class WorkoutModel {
  final LocalStorage storage = LocalStorage(workoutStorageKey);

  final List<Workout> _workout = [];
  List<Workout> get getWorkoutList => _workout;

  saveWorkout() async {
    try {
      final ready = await storage.ready;
      if (ready) {
        var json = _workout.map((e) => e.toJson()).toList();
        var arr = jsonEncode(json);
        await storage.setItem(workoutStorageKey, arr);
      }
    } catch (e) {
      rethrow;
    }
  }

  loadWorkout() async {
    try {
      final ready = await storage.ready;
      if (ready) {
        final json = await storage.getItem(workoutStorageKey);
        var items;
        if (json != null) items = jsonDecode(json);
        if (items != null) {
          for (var item in items) {
            await addWorkout(Workout.fromJson(item));
          }
        }
        if (_workout.isEmpty) {
          for (var json in mockdata) {
            await addWorkout(Workout.fromJson(json));
          }
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  addWorkout(Workout w) async {
    _workout.add(w);
    await saveWorkout();
  }

  Future<Workout> addNewWorkout(String name) async {
    int nextid = _workout
        .reduce((value, element) => (value.id > element.id) ? value : element)
        .id;
    var newWorkout =
        Workout(id: nextid, sets: [], name: name, date: DateTime.now());
    await addWorkout(newWorkout);
    return newWorkout;
  }

  addWorkoutSet(int i, WorkoutSet w) async {
    Workout current = _workout.firstWhere((element) => element.id == i);
    current.sets.add(w);
    _workout.removeWhere((element) => element.id == current.id);
    _workout.add(current);
  }

  deleteWorkoutSet() async {}
}
