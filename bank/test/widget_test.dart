import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bank/main.dart';  // Updated to reflect the correct import path

void main() {
  group('Bank App Tests', () {
    testWidgets('Welcomes the user and shows date on WelcomeScreen', (WidgetTester tester) async {
      await tester.pumpWidget(const BankApp());  // Updated to use BankApp

      expect(find.text('Welcome to Bank!'), findsOneWidget);
      expect(find.text('Today is'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Tap on the "View Accounts" button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Accounts'), findsOneWidget);
    });

    testWidgets('Logs in and navigates to AccountsScreen', (WidgetTester tester) async {
      await tester.pumpWidget(const BankApp());  // Updated to use BankApp

      // Navigate to the LoginScreen
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Enter valid credentials
      await tester.enterText(find.byKey(const Key('usernameField')), 'testuser');
      await tester.enterText(find.byKey(const Key('passwordField')), 'password');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Check if navigated to AccountsScreen
      expect(find.text('Accounts'), findsOneWidget);
    });

    testWidgets('Handles invalid login', (WidgetTester tester) async {
      await tester.pumpWidget(const BankApp());  // Updated to use BankApp

      // Navigate to the LoginScreen
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Enter invalid credentials
      await tester.enterText(find.byKey(const Key('usernameField')), 'wronguser');
      await tester.enterText(find.byKey(const Key('passwordField')), 'wrongpassword');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Please enter valid credentials'), findsOneWidget);
    });
  });
}
