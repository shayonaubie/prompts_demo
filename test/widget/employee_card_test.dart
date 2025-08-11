import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prompt_demo/features/employee/presentation/widgets/employee_card.dart';
import 'package:prompt_demo/shared/data/models/employee_model.dart';

void main() {
  group('EmployeeCard Widget Tests', () {
    late EmployeeModel testEmployee;

    setUp(() {
      testEmployee = EmployeeModel(
        id: 1,
        name: 'John Doe',
        role: 'Software Engineer',
        department: 'Engineering',
        email: 'john.doe@company.com',
        phone: '+1 (555) 123-4567',
        joinDate: DateTime(2022, 1, 15),
      );
    });

    testWidgets('should display employee information correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: EmployeeCard(employee: testEmployee)),
        ),
      );

      // Verify employee name is displayed
      expect(find.text('John Doe'), findsOneWidget);

      // Verify employee role is displayed
      expect(find.text('Software Engineer'), findsOneWidget);

      // Verify department is displayed
      expect(find.text('Engineering'), findsOneWidget);
    });

    testWidgets('should display initials when no profile picture provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: EmployeeCard(employee: testEmployee)),
        ),
      );

      // Should display initials 'JD' for 'John Doe'
      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('should call onTap when card is tapped', (
      WidgetTester tester,
    ) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmployeeCard(
              employee: testEmployee,
              onTap: () => wasTapped = true,
            ),
          ),
        ),
      );

      // Tap the card
      await tester.tap(find.byType(EmployeeCard));
      await tester.pump();

      expect(wasTapped, isTrue);
    });

    testWidgets('should handle long names with ellipsis', (
      WidgetTester tester,
    ) async {
      final longNameEmployee = testEmployee.copyWith(
        name: 'This is a very long name that should be truncated with ellipsis',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: EmployeeCard(employee: longNameEmployee),
            ),
          ),
        ),
      );

      // Find the text widget with the long name
      final nameText = tester.widget<Text>(
        find.text(
          'This is a very long name that should be truncated with ellipsis',
        ),
      );

      // Verify it has overflow handling
      expect(nameText.overflow, TextOverflow.ellipsis);
      expect(nameText.maxLines, 2);
    });

    testWidgets('should render card with correct styling', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: EmployeeCard(employee: testEmployee)),
        ),
      );

      // Verify Card widget exists
      expect(find.byType(Card), findsOneWidget);

      // Verify InkWell for tap interaction
      expect(find.byType(InkWell), findsOneWidget);

      // Verify Column layout
      expect(find.byType(Column), findsOneWidget);

      // Verify Container for profile picture
      expect(find.byType(Container), findsAtLeastNWidgets(1));
    });
  });
}
