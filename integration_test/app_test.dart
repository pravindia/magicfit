import 'package:app/config/constants.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';

import 'package:app/main.dart' as app;

void main() {
  group('Integral Tests', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets("Add workout list test", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final Finder addWorkoutButton = find.byKey(kaddNewWorkoutButton);
      final Finder addNameTextField = find.byKey(kaddworkoutTextkey);
      final Finder addWorkoutSubmit = find.byKey(kaddWorkoutSubmitButton);

      final Finder lists = find.byType(ListTile);
      final listCount = tester.widgetList(lists);
      // Future.delayed(Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(
        find.byKey(kaddNewWorkoutButton),
        findsOneWidget,
        reason: "Add new Floating action button not found",
      );
      await tester.tap(addWorkoutButton);
      await tester.pumpAndSettle();
      expect(
        find.byKey(kaddworkoutTextkey),
        findsOneWidget,
        reason: "Text field not found",
      );
      await tester.enterText(addNameTextField, "AUto text");

      await tester.tap(addWorkoutSubmit);
      await tester.pumpAndSettle();
      expect(find.text('AUto text'), findsOneWidget);
      expect(tester.widgetList(find.byType(ListTile)),
          findsNWidgets(listCount.length + 1));

      printOnFailure("Test Failed");
    });
  });
}
