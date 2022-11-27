import 'package:app/models/serializers/workout.dart';
import 'package:app/models/serializers/workout_set.dart';
import 'package:app/models/workout_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Unit Test \n', () {
    test('Test Workout to json', () {
      var newWorkout = Workout(id: 0, date: null, sets: [], name: "test name");
      expect(newWorkout.toJson(), isMap);
      expect(newWorkout.toJson(),
          {"id": 0, 'sets': [], 'name': "test name", 'date': ''});
    });
    test('Test Workout from json', () {
      // var newWorkout = Workout(id: 0, date: null, sets: [], name: "test name");
      var map = {"id": 1, 'sets': [], 'name': "test name", 'date': null};
      var res = Workout.fromJson(map);
      expect(res.id, map['id']);
      expect(res.date, DateTime.tryParse(map['date'].toString()));
    });
    test('Test WorkoutSet to json', () {
      var newWorkoutSet =
          WorkoutSet(exercise: ExerciseType.bench, reps: 12, weight: 21);
      expect(newWorkoutSet.toJson(), isMap, reason: "Errors in json parsing");
      expect(newWorkoutSet.toJson(),
          {"weight": 21, 'reps': 12, 'exercise': "Bench press"},
          reason: "Error in parsed values");
    });
    //
    test('Test WorkoutSet from json', () {
      // var newWorkout = Workout(id: 0, date: null, sets: [], name: "test name");
      var map = {"weight": 21, 'reps': 12, 'exercise': "Bench press"};
      var res = WorkoutSet.fromJson(map);
      expect(res.runtimeType == WorkoutSet, isTrue,
          reason: "Json not parsed properly");
      expect(res.reps, map['reps'], reason: "Errors in json parsing");
    });
  });
}
