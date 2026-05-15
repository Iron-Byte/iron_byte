import 'package:flutter/material.dart';

/// Fixed offset used for consultation hours (product requirement: GMT+2).
const Duration kConsultationGmt2Offset = Duration(hours: 2);

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// First selectable calendar day (today, local midnight).
DateTime consultationFirstSelectableDay() {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day);
}

/// Last selectable day: end of the month **after** the current month.
DateTime consultationLastSelectableDay(DateTime now) {
  final startOfMonthAfterNext = DateTime(now.year, now.month + 2, 1);
  return startOfMonthAfterNext.subtract(const Duration(days: 1));
}

/// Allowed booking dates: current and next calendar month, no past days.
bool isConsultationDateSelectable(DateTime day, DateTime now) {
  final d = _dateOnly(day);
  final first = consultationFirstSelectableDay();
  final last = consultationLastSelectableDay(now);
  return !d.isBefore(first) && !d.isAfter(last);
}

/// Consultation hours are 08:00–16:00 interpreted as wall time in GMT+2.
bool isValidConsultationTime(TimeOfDay time) {
  final minutes = time.hour * 60 + time.minute;
  return minutes >= 8 * 60 && minutes <= 16 * 60;
}

/// Combines a calendar [date] with [wallTime] treated as GMT+2 into a UTC instant.
DateTime toUtcInstantForGmtPlus2(DateTime date, TimeOfDay wallTime) {
  return DateTime.utc(
    date.year,
    date.month,
    date.day,
    wallTime.hour - 2,
    wallTime.minute,
  );
}

/// Formats a stored UTC instant for mail bodies (interprets via [kConsultationGmt2Offset]).
String formatConsultationSlotForBody(DateTime utcInstant) {
  final wall = utcInstant.add(kConsultationGmt2Offset);
  final y = wall.year;
  final m = wall.month.toString().padLeft(2, '0');
  final d = wall.day.toString().padLeft(2, '0');
  final h = wall.hour.toString().padLeft(2, '0');
  final min = wall.minute.toString().padLeft(2, '0');
  return '$y-$m-$d $h:$min (GMT+2)';
}

/// `yyyy-MM-dd HH:mm:ss` in GMT+2 wall time — format accepted by the reservations API.
String formatConsultationDateForApi(DateTime utcInstant) {
  final wall = utcInstant.add(kConsultationGmt2Offset);
  final y = wall.year;
  final m = wall.month.toString().padLeft(2, '0');
  final d = wall.day.toString().padLeft(2, '0');
  final h = wall.hour.toString().padLeft(2, '0');
  final min = wall.minute.toString().padLeft(2, '0');
  final sec = wall.second.toString().padLeft(2, '0');
  return '$y-$m-$d $h:$min:$sec';
}
