import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/core/utils/consultation_booked_slots.dart';
import 'package:iron_byte/core/utils/consultation_schedule.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_bloc.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_event.dart';
import 'package:iron_byte/features/home/presentation/bloc/home_consultation_state.dart';

/// Date and time picker for consultation slots, respecting booked API slots.
class ConsultationCalendarPicker extends StatelessWidget {
  const ConsultationCalendarPicker({
    super.key,
    required this.state,
    required this.isSending,
  });

  final HomeConsultationState state;
  final bool isSending;

  @override
  Widget build(BuildContext context) {
    final slot = state.preferredConsultationSlotUtc;
    final booked = state.bookedSlotsUtc;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton.icon(
          onPressed: isSending || state.isLoadingBookedSlots
              ? null
              : () => _openPicker(context, booked),
          icon: state.isLoadingBookedSlots
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.calendar_month, size: 18),
          label: Text('consultation.calendar.cta'.tr()),
        ),
        if (state.bookedSlotsErrorKey != null) ...[
          const Gap(AppSpacing.sm8),
          Text(
            _localizedMessage(state.bookedSlotsErrorKey!),
            style: AppTextStyles.bodySmall.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
        if (slot != null) ...[
          const Gap(AppSpacing.sm8),
          Text(
            'consultation.calendar.selected'.tr(
              namedArgs: {
                'slot': formatConsultationSlotForBody(slot),
              },
            ),
            style: AppTextStyles.bodySmall,
          ),
        ],
      ],
    );
  }

  String _localizedMessage(String message) {
    if (message.startsWith('consultation.')) return message.tr();
    return message;
  }

  Future<void> _openPicker(
    BuildContext context,
    List<DateTime> bookedSlotsUtc,
  ) async {
    final now = DateTime.now();
    final bloc = context.read<HomeConsultationBloc>();
    final first = consultationFirstSelectableDay();
    final last = consultationLastSelectableDay(now);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: first,
      firstDate: first,
      lastDate: last,
      selectableDayPredicate: (day) {
        if (!isConsultationDateSelectable(day, now)) return false;
        return !isConsultationDateBooked(day, bookedSlotsUtc);
      },
    );
    if (!context.mounted || pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
      helpText: 'consultation.calendar.time_help'.tr(),
    );
    if (!context.mounted || pickedTime == null) return;

    if (!isValidConsultationTime(pickedTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('consultation.snackbar.time_invalid'.tr())),
      );
      return;
    }

    final slotUtc = toUtcInstantForGmtPlus2(pickedDate, pickedTime);
    if (isConsultationSlotBooked(slotUtc, bookedSlotsUtc)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('consultation.error.slot_taken'.tr())),
      );
      return;
    }

    bloc.add(HomeConsultationPreferredSlotChanged(slotUtc));
  }
}
