import 'package:flutter_test/flutter_test.dart';
import 'package:prompt_demo/core/utils/app_utils.dart';

void main() {
  group('AppUtils Tests', () {
    group('isValidEmail', () {
      test('should return true for valid email', () {
        // arrange
        const email = 'test@example.com';

        // act
        final result = AppUtils.isValidEmail(email);

        // assert
        expect(result, true);
      });

      test('should return false for invalid email without @', () {
        // arrange
        const email = 'testexample.com';

        // act
        final result = AppUtils.isValidEmail(email);

        // assert
        expect(result, false);
      });

      test('should return false for invalid email without domain', () {
        // arrange
        const email = 'test@';

        // act
        final result = AppUtils.isValidEmail(email);

        // assert
        expect(result, false);
      });

      test('should return false for empty email', () {
        // arrange
        const email = '';

        // act
        final result = AppUtils.isValidEmail(email);

        // assert
        expect(result, false);
      });
    });

    group('formatCurrency', () {
      test('should format currency with 2 decimal places', () {
        // arrange
        const amount = 123.45;

        // act
        final result = AppUtils.formatCurrency(amount);

        // assert
        expect(result, '\$123.45');
      });

      test('should format whole number with .00', () {
        // arrange
        const amount = 100.0;

        // act
        final result = AppUtils.formatCurrency(amount);

        // assert
        expect(result, '\$100.00');
      });
    });
  });
}
