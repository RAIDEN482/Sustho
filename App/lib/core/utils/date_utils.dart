import 'package:intl/intl.dart';

/// Returns a date-only [DateTime] (no time component).
DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

DateTime today() => dateOnly(DateTime.now());

DateTime startOfMonth(DateTime d) => DateTime(d.year, d.month, 1);

DateTime addMonths(DateTime d, int months) {
  var month = d.month + months;
  var year = d.year;
  while (month > 12) {
    month -= 12;
    year += 1;
  }
  while (month < 1) {
    month += 12;
    year -= 1;
  }
  final day = d.day > _daysInMonth(year, month)
      ? _daysInMonth(year, month)
      : d.day;
  return DateTime(year, month, day);
}

int _daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

int daysInMonth(DateTime d) => DateTime(d.year, d.month + 1, 0).day;

/// Number of whole days from [a] to [b] (b - a).
int daysBetween(DateTime a, DateTime b) {
  final da = dateOnly(a);
  final db = dateOnly(b);
  return db.difference(da).inDays;
}

/// Formats a duration of [days] relative to today in a compact form.
/// e.g. "in 3 days" / "3 days ago" / "today".
String relativeDayLabel(DateTime day, {required DateTime now}) {
  final diff = daysBetween(now, day);
  if (diff == 0) return 'today';
  if (diff > 0) return 'in $diff day${diff == 1 ? '' : 's'}';
  final abs = -diff;
  return '$abs day${abs == 1 ? '' : 's'} ago';
}

String formatDate(DateTime d, {String? pattern}) {
  return DateFormat(pattern ?? 'MMM d, yyyy').format(d);
}
