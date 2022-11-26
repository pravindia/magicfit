import 'package:app/config/constants.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';

import 'package:app/main.dart' as app;

void main() {
  group('Integral Tests', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets("Add workout list test", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final Finder addWorkoutButton = find.byKey(kaddNewWorkoutButton);
      final Finder addNameTextField = find.byKey(kaddworkoutTextkey);
      final Finder addWorkoutSubmit = find.byKey(kaddWorkoutSubmitButton);

      final Finder lists = find.byType(ListTile);
      final listCount = tester.widgetList(lists);

      await Future.delayed(const Duration(seconds: 1));

      await tester.tap(addWorkoutButton);
      await Future.delayed(const Duration(seconds: 1));
      await tester.enterText(addNameTextField, "AUto text");
      await Future.delayed(const Duration(seconds: 1));

      await tester.tap(addWorkoutSubmit);

      // final int listCount = find.
      await Future.delayed(const Duration(seconds: 1));
      expect(find.byElementType(ListTile), findsNWidgets(listCount.length + 1));

      expect(find.text('AUto text'), findsOneWidget);

      printOnFailure("Error in test");
    });
  });
}
