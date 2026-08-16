const List<String> kBnDigits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];

/// Converts ASCII digits inside [input] to Bangla numerals.
String toBnDigits(String input) {
  final sb = StringBuffer();
  for (final ch in input.split('')) {
    final code = ch.codeUnitAt(0);
    if (code >= 0x30 && code <= 0x39) {
      sb.write(kBnDigits[code - 0x30]);
    } else {
      sb.write(ch);
    }
  }
  return sb.toString();
}

/// Returns [number] formatted with Bangla digits when [bn] is true.
String localizeNumber(int number, {required bool bn}) {
  final raw = number.toString();
  return bn ? toBnDigits(raw) : raw;
}
