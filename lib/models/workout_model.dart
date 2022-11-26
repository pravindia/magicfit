import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

import '../config/constants.dart';
import './serializers/workout.dart';
import './serializers/workout_set.dart';

class WorkoutModel with ChangeNotifier {
  final LocalStorage storage = LocalStorage(workoutStorageKey);

  final List<Workout> _workout = [];
  List<Workout> get getWorkoutList => _workout;

  WorkoutModel() {
    loadWorkout();
  }

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
            _workout.add(Workout.fromJson(item));
          }
        }
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  addWorkout(Workout w) async {
    _workout.add(w);
    await saveWorkout();
  }

  Future addNewWorkout(String name) async {
    int nextid = _workout.isNotEmpty
        ? _workout.reduce((v, e) => (v.id > e.id) ? v : e).id + 1
        : 0;
    var newWorkout =
        Workout(id: nextid, sets: [], name: name, date: DateTime.now());
    await addWorkout(newWorkout);
    notifyListeners();
  }

  addWorkoutSet(int i, WorkoutSet w) async {
    Workout current = _workout.firstWhere((element) => element.id == i);
    current.sets.add(w);
    _workout.removeWhere((element) => element.id == current.id);
    _workout.add(current);
    await saveWorkout();
    notifyListeners();
  }

  deleteWorkout(Workout w) async {
    _workout.removeWhere((element) => element.id == w.id);
    await saveWorkout();
    notifyListeners();
  }

  deleteWorkoutSet(int i, WorkoutSet w) async {
    Workout current = _workout.firstWhere((element) => element.id == i);
    current.sets.remove(w);
    _workout.removeWhere((element) => element.id == current.id);
    _workout.add(current);
    await saveWorkout();
    notifyListeners();
  }
}
