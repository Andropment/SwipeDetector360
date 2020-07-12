// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swipe_detector_360/swipe_detector_360_sample.dart';

void main() {
  testWidgets(
    'Gesture Widget test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WidgetSample4SwipeDetector360(),
          ),
        ),
      );

      final targetFinder = find.text('swipe');
      expect(targetFinder, findsOneWidget);
      final Offset centerPoint = //Offset(200, 200);
          tester.getCenter(find.byType(WidgetSample4SwipeDetector360));

      expect(find.text('swipe starts : '), findsNothing);

      await tester.flingFrom(centerPoint, const Offset(50, 50), 1000);
      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.text('swipe to Bottom-right : '), findsOneWidget);

      await tester.flingFrom(centerPoint, const Offset(-50, 50), 1000);
      await tester.pumpAndSettle();
      expect(find.text('swipe to Bottom-left : '), findsOneWidget);

      await tester.flingFrom(centerPoint, Offset(50, -50), 1000);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text('swipe to Top-right : '), findsOneWidget);

      await tester.flingFrom(centerPoint, Offset(-50, -50), 1000);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text('swipe to Top-left : '), findsOneWidget);

      await expectLater(find.text('swipe doing : '), findsNothing);
    },
  );
}
