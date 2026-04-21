import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/core/utils/consultation_schedule.dart';

/// Native date + time pickers with consultation scheduling rules.
Future<DateTime?> pickConsultationSlot(BuildContext context) async {
  final now = DateTime.now();
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: consultationFirstSelectableDay(),
    firstDate: consultationFirstSelectableDay(),
    lastDate: consultationLastSelectableDay(now),
    selectableDayPredicate: (day) => isConsultationDateSelectable(day, now),
  );
  if (!context.mounted || pickedDate == null) return null;

  while (context.mounted) {
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
      helpText: 'consultation.calendar.time_help'.tr(),
    );
    if (!context.mounted) return null;
    if (time == null) return null;

    if (isValidConsultationTime(time)) {
      return toUtcInstantForGmtPlus2(pickedDate, time);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('consultation.snackbar.time_invalid'.tr()),
      ),
    );
  }
  return null;
}
