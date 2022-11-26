import 'package:app/models/serializers/workout.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Unit Test \n', () {
    test('Test Workout to json', () {
      var newWorkout = Workout(id: 0, date: null, sets: [], name: "test name");
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
  });
}
