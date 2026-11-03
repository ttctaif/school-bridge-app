/// Arabic-friendly relative date, e.g. "اليوم 4:30 م".
String formatDateTime(DateTime d) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final day = DateTime(d.year, d.month, d.day);
  final diff = today.difference(day).inDays;
  final time = _to12(d.hour, d.minute);
  if (diff == 0) return 'اليوم $time';
  if (diff == 1) return 'أمس $time';
  return '${d.day}/${d.month} $time';
}

/// "16:00" and "18:00" -> "من 4:00 م إلى 6:00 م".
String formatWorkWindow(String start, String end) =>
    'من ${_fromHhmm(start)} إلى ${_fromHhmm(end)}';

String _fromHhmm(String hhmm) {
  final p = hhmm.split(':');
  return _to12(int.parse(p[0]), int.parse(p[1]));
}

String _to12(int h, int m) {
  final suffix = h >= 12 ? 'م' : 'ص';
  final h12 = h % 12 == 0 ? 12 : h % 12;
  return '$h12:${m.toString().padLeft(2, '0')} $suffix';
}
