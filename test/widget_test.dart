import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prompt_demo/main.dart';

void main() {
  group('App Tests', () {
    testWidgets('App should build without errors', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that the app builds successfully
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Home page should display welcome message', (
      WidgetTester tester,
    ) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that our welcome text is present.
      expect(find.text('Welcome to Prompt Demo'), findsOneWidget);
      expect(
        find.text('This is your scalable Flutter app structure'),
        findsOneWidget,
      );
    });

    testWidgets('Home page should have app bar with Home title', (
      WidgetTester tester,
    ) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that app bar is present with correct title
      expect(find.text('Home'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });
  });
}
