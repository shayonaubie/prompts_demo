import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  // Theme
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  // Navigation
  NavigatorState get navigator => Navigator.of(this);

  void pop([dynamic result]) => Navigator.of(this).pop(result);

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) => Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) => Navigator.of(this).pushReplacementNamed<T, TO>(
    routeName,
    arguments: arguments,
    result: result,
  );

  // Responsive design helpers
  bool get isTablet => screenWidth >= 600;
  bool get isMobile => screenWidth < 600;
  bool get isDesktop => screenWidth >= 1200;

  // Common UI helpers
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }
}
