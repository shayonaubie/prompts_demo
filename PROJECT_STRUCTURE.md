# Flutter Project Structure

This project follows a **Clean Architecture** approach with **Feature-based** organization, ensuring scalability, maintainability, and testability.

## 📁 Project Structure

```
lib/
├── config/                     # App configuration
│   └── routes/
│       └── app_routes.dart     # Route definitions and navigation
├── core/                       # Core functionality (shared across features)
│   ├── constants/              # App-wide constants
│   │   ├── app_colors.dart     # Color definitions
│   │   ├── app_constants.dart  # General constants
│   │   └── app_strings.dart    # String constants
│   ├── error/                  # Error handling
│   │   └── failures.dart       # Failure classes
│   ├── extensions/             # Dart extensions
│   │   └── context_extensions.dart # BuildContext extensions
│   ├── theme/                  # App theming
│   │   └── app_theme.dart      # Light/Dark theme definitions
│   ├── usecases/               # Base use case classes
│   │   └── usecase.dart        # UseCase interfaces
│   ├── utils/                  # Utility functions
│   │   └── app_utils.dart      # Common utility methods
│   └── widgets/                # Reusable widgets
│       ├── custom_button.dart  # Custom button widget
│       ├── custom_text_field.dart # Custom text field widget
│       └── loading_widget.dart # Loading indicator widget
├── features/                   # Feature modules
│   ├── auth/                   # Authentication feature
│   │   └── presentation/
│   │       └── pages/
│   │           └── login_page.dart
│   └── home/                   # Home feature
│       └── presentation/
│           └── pages/
│               └── home_page.dart
├── shared/                     # Shared data models and services
│   └── data/
│       └── models/
│           └── user_model.dart # User data model
└── main.dart                   # App entry point

test/
├── unit/                       # Unit tests
│   └── core/
│       └── utils/
│           └── app_utils_test.dart
└── widget_test.dart           # Widget tests
```

## 🏗️ Architecture Overview

### Clean Architecture Layers

1. **Presentation Layer** (`features/*/presentation/`)

   - Pages/Screens
   - Widgets
   - BLoC/State Management (to be added)

2. **Domain Layer** (`features/*/domain/`)

   - Entities
   - Use Cases
   - Repository Interfaces

3. **Data Layer** (`features/*/data/`)
   - Repository Implementations
   - Data Sources (API, Cache)
   - Models

### Core Modules

- **Constants**: Centralized app constants for colors, strings, and configuration
- **Theme**: Material 3 design system with light/dark theme support
- **Utils**: Common utility functions and helpers
- **Widgets**: Reusable UI components
- **Error**: Standardized error handling with failure classes
- **Extensions**: Dart extensions for enhanced functionality

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.8.1 or higher
- Dart SDK 3.8.1 or higher

### Installation

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app

### Running Tests

```bash
# Run all tests
flutter test

# Run unit tests
flutter test test/unit/

# Run widget tests
flutter test test/widget_test.dart
```

## 📱 Features

### Current Features

- **Clean Architecture Structure**: Organized codebase following clean architecture principles
- **Material 3 Design**: Modern UI with Material 3 design system
- **Theme Support**: Light and dark theme with system preference detection
- **Navigation**: Centralized route management
- **Reusable Widgets**: Custom components for consistent UI
- **Error Handling**: Standardized failure classes for robust error management
- **Testing**: Unit and widget tests with proper test structure

### Planned Features

- State Management (BLoC pattern)
- API Integration
- Local Storage
- Authentication Flow
- Dependency Injection
- Localization

## 🔧 Adding New Features

### 1. Create Feature Structure

```
features/
└── your_feature/
    ├── data/
    │   ├── datasources/
    │   ├── models/
    │   └── repositories/
    ├── domain/
    │   ├── entities/
    │   ├── repositories/
    │   └── usecases/
    └── presentation/
        ├── bloc/
        ├── pages/
        └── widgets/
```

### 2. Add Routes

Update `lib/config/routes/app_routes.dart` with new route definitions.

### 3. Update Constants

Add feature-specific strings to `lib/core/constants/app_strings.dart`.

## 🎨 Theming

The app uses Material 3 design system with custom color schemes defined in:

- `lib/core/constants/app_colors.dart`
- `lib/core/theme/app_theme.dart`

### Custom Colors

```dart
AppColors.primary      // Primary brand color
AppColors.secondary    // Secondary brand color
AppColors.success      // Success state color
AppColors.error        // Error state color
AppColors.warning      // Warning state color
```

## 🧪 Testing Strategy

### Unit Tests

- Test business logic in isolation
- Mock external dependencies
- Focus on use cases and utilities

### Widget Tests

- Test UI components
- Verify widget behavior
- Test user interactions

### Integration Tests

- Test complete user flows
- Verify feature integration
- Test navigation and state management

## 📦 Dependencies

Current dependencies are minimal to maintain a clean base structure:

```yaml
dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

Additional dependencies will be added as features are implemented.

## 🤝 Contributing

1. Follow the established folder structure
2. Maintain consistent coding style
3. Write tests for new features
4. Update documentation as needed
5. Use meaningful commit messages

## 📝 Code Style

- Use meaningful variable and function names
- Follow Dart naming conventions
- Add comments for complex logic
- Keep functions small and focused
- Use const constructors where possible

## 🔍 Best Practices

1. **Single Responsibility**: Each class should have one reason to change
2. **Dependency Inversion**: Depend on abstractions, not concretions
3. **Separation of Concerns**: Keep business logic separate from UI
4. **Consistent Error Handling**: Use standardized failure classes
5. **Testable Code**: Write code that's easy to test
6. **Responsive Design**: Consider different screen sizes
7. **Performance**: Use const constructors and optimize widget rebuilds

This structure provides a solid foundation for building scalable Flutter applications while maintaining code quality and developer productivity.
