import 'package:app/components/empty_state.dart';
import 'package:app/config/mock_data.dart';
import 'package:app/models/serializers/workout.dart';
import 'package:app/models/workout_model.dart';
import 'package:app/screens/workout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('Widget Tests', () {
    testWidgets("Empty State Widget Test", (WidgetTester tester) async {
      //
      await tester.pumpWidget(const MaterialApp(
        home: EmptyState(),
      ));
      expect(find.text("List empty. Add one"), findsOneWidget);
    });
    testWidgets("WorkoutSet List widget test", (WidgetTester tester) async {
      //
      final Workout w = Workout.fromJson(mockdata[0]);
      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<WorkoutModel>.value(value: WorkoutModel())
        ],
        child: MaterialApp(
          home: WorkoutPage(workout: w),
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.byType(ListTile), findsNWidgets(w.sets.length));
    });
  });
}
