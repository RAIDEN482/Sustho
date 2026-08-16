import 'package:intl/intl.dart';

/// Date formatting helpers that render Bangla numerals and Bangla month/day
/// names when the [bn] flag is true.
class DateFormats {
  DateFormats._();

  static const List<String> _enMonths = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  static const List<String> _bnMonths = [
    'জানুয়ারি', 'ফেব্রুয়ারি', 'মার্চ', 'এপ্রিল', 'মে', 'জুন',
    'জুলাই', 'আগস্ট', 'সেপ্টেম্বর', 'অক্টোবর', 'নভেম্বর', 'ডিসেম্বর',
  ];

  static const List<String> _enWeekdays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday',
  ];

  static const List<String> _bnWeekdays = [
    'সোমবার', 'মঙ্গলবার', 'বুধবার', 'বৃহস্পতিবার',
    'শুক্রবার', 'শনিবার', 'রবিবার',
  ];

  static const List<String> _enWeekdaysShort = [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
  ];

  static const List<String> _bnWeekdaysShort = [
    'সোম', 'মঙ্গল', 'বুধ', 'বৃহঃ', 'শুক্র', 'শনি', 'রবি',
  ];

  static String _digits(int n, bool bn) {
    final s = n.toString();
    if (!bn) return s;
    const bnDigits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
    return s.split('').map((c) => bnDigits[c.codeUnitAt(0) - 0x30]).join();
  }

  /// e.g. "August 12, 2026" or "১২ আগস্ট ২০২৬"
  static String full(DateTime d, {required bool bn}) {
    if (bn) {
      return '${_digits(d.day, true)} ${_bnMonths[d.month - 1]} ${_digits(d.year, true)}';
    }
    return '${_enMonths[d.month - 1]} ${d.day}, ${d.year}';
  }

  /// e.g. "12 August" or "১২ আগস্ট"
  static String dayMonth(DateTime d, {required bool bn}) {
    if (bn) {
      return '${_digits(d.day, true)} ${_bnMonths[d.month - 1]}';
    }
    return '${_enMonths[d.month - 1]} ${d.day}';
  }

  /// e.g. "August 2026" or "আগস্ট ২০২৬"
  static String monthYear(DateTime d, {required bool bn}) {
    if (bn) {
      return '${_bnMonths[d.month - 1]} ${_digits(d.year, true)}';
    }
    return '${_enMonths[d.month - 1]} ${d.year}';
  }

  /// e.g. "Wednesday" or "বুধবার"
  static String weekday(DateTime d, {required bool bn}) {
    final idx = d.weekday - 1;
    return bn ? _bnWeekdays[idx] : _enWeekdays[idx];
  }

  /// e.g. "Wed" or "বুধ"
  static String weekdayShort(DateTime d, {required bool bn}) {
    final idx = d.weekday - 1;
    return bn ? _bnWeekdaysShort[idx] : _enWeekdaysShort[idx];
  }

  static String digits(int n, {required bool bn}) => _digits(n, bn);

  static String compactDay(DateTime d, {required bool bn}) {
    return _digits(d.day, bn);
  }

  /// Uses intl for arbitrary patterns, then converts digits to Bangla.
  static String pattern(DateTime d, String enPattern, {required bool bn}) {
    final formatted = DateFormat(enPattern).format(d);
    if (!bn) return formatted;
    return _digitsFromString(formatted);
  }

  static String _digitsFromString(String input) {
    const en = '0123456789';
    const bn = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
    return input.split('').map((c) {
      final idx = en.indexOf(c);
      return idx >= 0 ? bn[idx] : c;
    }).join();
  }
}
