import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/core/theme/colors.dart';

class TimeWheelPicker extends StatefulWidget {
  final int initialHour;
  final int initialMinute;
  final int initialPeriod;

  final Function(int hour) onHourChanged;
  final Function(int minute) onMinuteChanged;
  final Function(int period) onPeriodChanged;

  const TimeWheelPicker({
    super.key,
    required this.onHourChanged,
    required this.onMinuteChanged,
    required this.onPeriodChanged,
    required this.initialHour,
    required this.initialMinute,
    required this.initialPeriod,
  });

  @override
  State<TimeWheelPicker> createState() => _TimeWheelPickerState();
}

class _TimeWheelPickerState extends State<TimeWheelPicker> {
  final List<String> periods = ['AM', 'PM'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPickerColumn(
          itemCount: 12,
          initialItem: widget.initialHour - 1,
          onChanged: (index) {
            widget.onHourChanged(index + 1);
          },
          labelBuilder: (index) => (index + 1).toString().padLeft(2, '0'),
        ),
        const Text(
          " : ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        _buildPickerColumn(
          itemCount: 60,
          initialItem: widget.initialMinute,
          onChanged: (index) {
            widget.onMinuteChanged(index);
          },
          labelBuilder: (index) => index.toString().padLeft(2, '0'),
        ),
        const SizedBox(width: 10),

        _buildPickerColumn(
          itemCount: 2,
          initialItem: widget.initialPeriod,
          onChanged: (index) {
            widget.onPeriodChanged(index);
          },
          labelBuilder: (index) => periods[index],
        ),
      ],
    );
  }

  Widget _buildPickerColumn({
    required int itemCount,
    required int initialItem,
    required ValueChanged<int> onChanged,
    required String Function(int) labelBuilder,
  }) {
    return SizedBox(
      width: 64,
      height: 64,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorDark.cellItemInMonthBackground,
        ),
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: CupertinoPicker(
          scrollController: FixedExtentScrollController(
            initialItem: initialItem,
          ),
          itemExtent: 36,
          selectionOverlay: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
          looping: false,
          onSelectedItemChanged: onChanged,
          children: List.generate(itemCount, (index) {
            return Center(
              child: Text(
                labelBuilder(index),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

Future<TimeOfDay?> showCustomTimePicker(
  BuildContext context,
  TimeOfDay initialTime,
) async {
  int selectedHour = initialTime.hourOfPeriod;
  int selectedMinute = initialTime.minute;
  int selectedPeriodIndex = initialTime.period == DayPeriod.pm ? 1 : 0;
  return showDialog<TimeOfDay>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppConstants.CHOOSE_TIME,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              const Divider(
                color: ColorDark.dividerColor,
                thickness: 1,
                height: 1,
              ),
              const SizedBox(height: 20),
              TimeWheelPicker(
                initialHour: selectedHour,
                initialMinute: selectedMinute,
                initialPeriod: selectedPeriodIndex,
                onHourChanged: (hour) {
                  selectedHour = hour;
                },
                onMinuteChanged: (minute) {
                  selectedMinute = minute;
                },
                onPeriodChanged: (period) {
                  selectedPeriodIndex = period;
                  debugPrint(period.toString());
                },
              ),
              const SizedBox(height: 20),
              Row(
                spacing: 5,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (context.canPop()) context.pop();
                      },
                      child: Text(
                        AppConstants.CANCEL,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorDark.primary,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () {
                        debugPrint("hour: $selectedHour minute: $selectedMinute");
                        int newHour = selectedHour;
                        if (selectedPeriodIndex == 1) {
                          newHour = (selectedHour == 12) ? 12 : selectedHour + 12;
                        } else {
                          newHour = (selectedHour == 12) ? 0 : selectedHour;
                        }
                        debugPrint("new hour: $newHour");
                        final result = initialTime.replacing(hour: newHour, minute: selectedMinute);
                        debugPrint(result.toString());
                        if (context.canPop()) context.pop(result);
                      },
                      child: Text(
                        AppConstants.SAVE,
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
