// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutSet _$WorkoutSetFromJson(Map<String, dynamic> json) => WorkoutSet(
      weight: WorkoutSet._stringToInt(json['weight']),
      reps: WorkoutSet._stringToInt(json['reps']),
      exercise: $enumDecode(_$ExerciseTypeEnumMap, json['exercise']),
    );

Map<String, dynamic> _$WorkoutSetToJson(WorkoutSet instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'reps': instance.reps,
      'exercise': _$ExerciseTypeEnumMap[instance.exercise]!,
    };

const _$ExerciseTypeEnumMap = {
  ExerciseType.barbell: 'Barbell row',
  ExerciseType.bench: 'Bench press',
  ExerciseType.shoulder: 'Shoulder press',
  ExerciseType.deadlift: 'Deadlift',
  ExerciseType.squat: 'Squat',
};
