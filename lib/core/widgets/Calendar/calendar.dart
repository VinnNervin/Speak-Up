import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:first_app/theme/app_colors.dart';
import 'package:first_app/theme/app_fonts.dart';

class AppCalendar extends StatefulWidget {
  const AppCalendar({super.key});

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, Color> _eventColors = {
    DateTime(DateTime.now().year, DateTime.now().month, 7): AppColors.orange,
    DateTime(DateTime.now().year, DateTime.now().month, 11):
        AppColors.secondary,
  };

  Color? _highlightColor(DateTime day) {
    final key = DateTime(day.year, day.month, day.day);
    return _eventColors[key];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: TableCalendar(
          locale: 'id_ID',
          // ── Range ────────────────────────────────────────────────
          firstDay: DateTime.utc(2000, 1, 1),
          lastDay: DateTime.utc(2050, 12, 31),
          focusedDay: _focusedDay,

          // ── Selection ────────────────────────────────────────────
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },

          // ── Format ───────────────────────────────────────────────
          calendarFormat: CalendarFormat.month,
          availableCalendarFormats: const {CalendarFormat.month: 'Month'},
          startingDayOfWeek: StartingDayOfWeek.monday,

          // ── Header style ─────────────────────────────────────────
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: false,
            leftChevronIcon: const Icon(
              Icons.chevron_left,
              color: AppColors.black,
              size: 22,
            ),
            rightChevronIcon: const Icon(
              Icons.chevron_right,
              color: AppColors.black,
              size: 22,
            ),
            titleTextStyle: const TextStyle(
              fontSize: AppFonts.fontLarge,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
            headerPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            headerMargin: EdgeInsets.zero,
          ),

          // ── Days-of-week style ───────────────────────────────────
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              fontSize: AppFonts.fontSmall,
              fontWeight: FontWeight.w600,
              color: AppColors.black.withValues(alpha: 0.5),
              letterSpacing: 0.5,
            ),
            weekendStyle: TextStyle(
              fontSize: AppFonts.fontSmall,
              fontWeight: FontWeight.w600,
              color: AppColors.black.withValues(alpha: 0.5),
              letterSpacing: 0.5,
            ),
          ),

          // ── Calendar style ───────────────────────────────────────
          calendarStyle: CalendarStyle(
            // Remove default decorations – we use builders instead
            defaultDecoration: const BoxDecoration(),
            weekendDecoration: const BoxDecoration(),
            outsideDecoration: const BoxDecoration(),
            selectedDecoration: const BoxDecoration(),
            todayDecoration: const BoxDecoration(),
            markerDecoration: const BoxDecoration(),

            // Text styles
            defaultTextStyle: TextStyle(
              fontSize: AppFonts.fontMedium,
              fontWeight: FontWeight.w600,
              color: AppColors.black.withValues(alpha: 0.85),
            ),
            weekendTextStyle: TextStyle(
              fontSize: AppFonts.fontMedium,
              fontWeight: FontWeight.w600,
              color: AppColors.black.withValues(alpha: 0.85),
            ),
            outsideTextStyle: TextStyle(
              fontSize: AppFonts.fontMedium,
              fontWeight: FontWeight.w500,
              color: AppColors.black.withValues(alpha: 0.25),
            ),
            selectedTextStyle: const TextStyle(
              fontSize: AppFonts.fontMedium,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
            todayTextStyle: const TextStyle(
              fontSize: AppFonts.fontMedium,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),

            cellMargin: const EdgeInsets.all(4),
          ),

          // ── Custom cell builders ─────────────────────────────────
          calendarBuilders: CalendarBuilders(
            // Today
            todayBuilder: (context, day, focusedDay) =>
                _buildDayCell(day, AppColors.primary, AppColors.white),

            // Selected (but not today)
            selectedBuilder: (context, day, focusedDay) =>
                isSameDay(day, DateTime.now())
                ? _buildDayCell(day, AppColors.primary, AppColors.white)
                : _buildDayCell(day, AppColors.purple, AppColors.white),

            // Default days (override to support event colours)
            defaultBuilder: (context, day, focusedDay) {
              final color = _highlightColor(day);
              if (color != null) {
                return _buildDayCell(day, color, AppColors.white);
              }
              return null; // use default CalendarStyle
            },

            // Outside month days
            outsideBuilder: (context, day, focusedDay) {
              return Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    fontSize: AppFonts.fontMedium,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black.withValues(alpha: 0.25),
                  ),
                ),
              );
            },

            // Disable default event markers
            markerBuilder: (context, day, events) => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }

  /// Builds a rounded square cell with [bgColor] background and [textColor] text.
  Widget _buildDayCell(DateTime day, Color bgColor, Color textColor) {
    return Center(
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          '${day.day}',
          style: TextStyle(
            fontSize: AppFonts.fontMedium,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
