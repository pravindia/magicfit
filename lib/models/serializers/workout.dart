import 'workout_set.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout.g.dart';

@JsonSerializable(explicitToJson: true)
@_DateTimeEpochConverter()
class Workout {
  int id;
  String? name;
  @JsonKey(defaultValue: <WorkoutSet>[])
  List<WorkoutSet> sets = [];
  DateTime? date;

  Workout({
    required this.id,
    this.name,
    this.date,
    required this.sets,
  });
  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutToJson(this);
}

class _DateTimeEpochConverter implements JsonConverter<DateTime?, String> {
  const _DateTimeEpochConverter();

  @override
  DateTime? fromJson(String string) => DateTime.tryParse(string);

  @override
  String toJson(DateTime? date) => date?.toIso8601String() ?? "";
}
