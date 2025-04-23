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

  /// Formats to 'MMM d' (e.g., Apr 10)
  String get formatAsShort {
    return DateFormat('MMM d').format(this);
  }

  /// Formats to 'MMM d, yyyy' (e.g., Apr 10, 2024)
  String get formatAsShortWithYear {
    return DateFormat('MMM d, yyyy').format(this);
  }
}
