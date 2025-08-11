import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/employee/presentation/pages/employee_directory_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String employeeDirectory = '/employee-directory';

  static Map<String, Widget Function(BuildContext)> get routes {
    return {
      home: (context) => const HomePage(),
      login: (context) => const LoginPage(),
      employeeDirectory: (context) => const EmployeeDirectoryPage(),
    };
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case login:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case employeeDirectory:
        return MaterialPageRoute(
          builder: (context) => const EmployeeDirectoryPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Page Not Found')),
            body: const Center(child: Text('404 - Page Not Found')),
          ),
        );
    }
  }
}
