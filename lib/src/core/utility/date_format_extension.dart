import 'package:intl/intl.dart';

/// Extension to add `formatAsDateOnly` on DateTime objects.
/// Example:
/// ```dart
/// final formatted = myDate.formatAsDateOnly; // "2024-12-01"
/// ```
extension DateFormatExtension on DateTime {
  String get formatAsDateOnly {
    return DateFormat('yyyy-MM-dd').format(this);
  }
}
