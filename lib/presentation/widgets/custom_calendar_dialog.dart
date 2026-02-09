import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/i18n/strings.g.dart';

class CustomCalendar extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime) onDateSelected;

  const CustomCalendar({
    super.key,
    required this.onDateSelected,
    this.initialDate,
  });

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialDate ?? DateTime.now();
    _selectedDay = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime(2000, 1, 1),
      lastDay: DateTime(2100, 1, 1),
      focusedDay: _focusedDay,
      sixWeekMonthsEnforced: true,
      calendarBuilders: CalendarBuilders(
        outsideBuilder: (context, day, focusedDay) {
          return _buildDayCell(day, textColor: ColorDark.gray);
        },
        defaultBuilder: (context, day, focusedDay) {
          return _buildDayCell(
            day,
            textColor: ColorDark.whiteFocus,
            background: ColorDark.cellItemInMonthBackground,
          );
        },
        selectedBuilder: (context, day, focusedDay) {
          return _buildDayCell(
            day,
            textColor: Colors.white,
            background: ColorDark.primary,
          );
        },
        todayBuilder: (context, day, focusedDay) {
          return _buildDayCell(
            day,
            textColor: ColorDark.whiteFocus,
            background: ColorDark.cellItemInMonthBackground,
          );
        },
        headerTitleBuilder: (context, day) {
          final month = DateFormat.MMMM(
            LocaleSettings.currentLocale.languageCode,
          ).format(day).toUpperCase();
          final year = DateFormat.y(
            LocaleSettings.currentLocale.languageCode,
          ).format(day);
          return Column(
            children: [
              Text(
                month,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  color: ColorDark.whiteFocus,
                ),
              ),
              Text(
                year,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                  color: ColorDark.gray,
                ),
              ),
            ],
          );
        },
      ),

      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        widget.onDateSelected(selectedDay);
      },

      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },

      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronIcon: SvgPicture.asset(Assets.iconsIcChevronLeft),
        rightChevronIcon: SvgPicture.asset(Assets.iconsIcChevronRight),
        headerPadding: const EdgeInsets.only(bottom: 8),
        headerMargin: const EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: ColorDark.dividerColor, width: 1.0),
          ),
        ),
      ),

      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: const TextStyle(color: ColorDark.whiteFocus),
        weekendStyle: const TextStyle(color: ColorDark.error),
        dowTextFormatter: (date, locale) {
          final text = DateFormat.E(LocaleSettings.currentLocale.languageCode).format(date);
          return text.toUpperCase();
        },
      ),
      daysOfWeekHeight: 20,
    );
  }

  Widget _buildDayCell(
    DateTime day, {
    required Color textColor,
    Color? background,
  }) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: Text(
          '${day.day}',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontSize: 12, color: textColor),
        ),
      ),
    );
  }
}

enum CalendarDialogMode { create, edit }

Future<DateTime?> showAppCalendarDialog({
  required BuildContext context,
  required DateTime initialDate,
  CalendarDialogMode mode = CalendarDialogMode.create,
}) {
  return showDialog<DateTime>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      DateTime tempSelectedDate = initialDate;
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomCalendar(
                onDateSelected: (date) {
                  tempSelectedDate = date;
                },
                initialDate: initialDate,
              ),
              const SizedBox(height: 23),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => context.pop(),
                      child: Text(
                        t.cancel,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorDark.primary,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () => context.pop(tempSelectedDate),
                      child: Text(
                        mode == CalendarDialogMode.create
                            ? t.choose_time
                            : t.edit_time,
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
