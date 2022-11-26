import 'package:json_annotation/json_annotation.dart';

part 'workout_set.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkoutSet {
  @JsonKey(fromJson: _stringToInt)
  late int weight;
  @JsonKey(fromJson: _stringToInt)
  late int reps;
  late ExerciseType exercise;

  WorkoutSet({
    required this.weight,
    required this.reps,
    required this.exercise,
  });
  factory WorkoutSet.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSetFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutSetToJson(this);

  static int _stringToInt(number) =>
      number != null ? int.parse(number.toString()) : 0;
}

@JsonEnum(valueField: 'value')
enum ExerciseType {
  barbell("Barbell row"),
  bench("Bench press"),
  shoulder("Shoulder press"),
  deadlift("Deadlift"),
  squat("Squat");

  const ExerciseType(this.value);
  final String value;
  static List<String> stringValues() =>
      ExerciseType.values.map((e) => e.name).toList();
}
