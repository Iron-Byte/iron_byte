import 'package:iron_byte/core/utils/consultation_schedule.dart';

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Wall-calendar day in GMT+2 for a stored UTC instant.
DateTime consultationWallDateFromUtc(DateTime utcInstant) {
  final wall = utcInstant.add(kConsultationGmt2Offset);
  return DateTime(wall.year, wall.month, wall.day);
}

/// True when [day] (date-only) has at least one booked slot.
bool isConsultationDateBooked(DateTime day, List<DateTime> bookedSlotsUtc) {
  final target = _dateOnly(day);
  for (final slot in bookedSlotsUtc) {
    if (_dateOnly(consultationWallDateFromUtc(slot)) == target) {
      return true;
    }
  }
  return false;
}

/// True when the exact UTC instant is already reserved.
bool isConsultationSlotBooked(DateTime slotUtc, List<DateTime> bookedSlotsUtc) {
  return bookedSlotsUtc.any((booked) => booked.toUtc() == slotUtc.toUtc());
}
