import 'package:date_utils/date_utils.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:keep_focus/module/home/state.dart';

class CalendarWidget extends StatefulWidget {
  final CalendarState calendarState;
  final DateTime monthDate;
  final void Function()? onSetCalendar;

  const CalendarWidget({
    super.key,
    this.calendarState = CalendarState.collapsed,
    required this.monthDate,
    this.onSetCalendar,
  });

  @override
  State<StatefulWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _monthDate;
  late List<DateTime> _dateTimeList;
  late DateTime _nowTime;

  @override
  void initState() {
    _monthDate = widget.monthDate;
    _dateTimeList = DateUtils.daysInMonth(_monthDate);
    _nowTime = DateTime.now();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CalendarWidget oldWidget) {
    setState(() {
      if (widget.calendarState == CalendarState.collapsed) {
        _monthDate = widget.monthDate;
      }
      _nowTime = DateTime.now();
      if (widget.calendarState == CalendarState.collapsed) {
        _monthDate = _nowTime;
        _dateTimeList = DateUtils.daysInMonth(_monthDate);
        final List<DateTime> thisWeek = [];
        for (DateTime dateTime in _dateTimeList) {
          if (DateUtils.isSameWeek(dateTime, _monthDate)) {
            thisWeek.add(dateTime);
          }
        }
        _dateTimeList.removeWhere(
            (dateTime) => DateUtils.isSameWeek(dateTime, _monthDate));
        _dateTimeList.insertAll(0, thisWeek);
      } else {
        _dateTimeList = DateUtils.daysInMonth(_monthDate);
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  void _switchMonth(bool isPrevious) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      widget.onSetCalendar?.call();
    });
    setState(() {
      _monthDate = isPrevious
          ? DateUtils.previousMonth(_monthDate)
          : DateUtils.nextMonth(_monthDate);
      _dateTimeList = DateUtils.daysInMonth(_monthDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedCrossFade(
            firstChild: _datePicker(
              context,
              monthDate: _monthDate,
              nowTime: _nowTime,
              switchMonth: (isPrevious) => _switchMonth(isPrevious),
            ),
            secondChild: _thisMonth(context, month: _monthDate.month),
            crossFadeState: widget.calendarState == CalendarState.expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(
              milliseconds: 200,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 8),
            child: _week(context),
          ),
          Flexible(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: _dateTimeList.length,
              itemBuilder: (BuildContext context, int index) {
                final DateTime day = _dateTimeList[index];
                final int actualDay = day.day;
                return _day(
                  context,
                  day: actualDay,
                  isToday: DateUtils.isSameDay(day, _nowTime),
                  isThisMonth: day.month == _monthDate.month,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget _datePicker(
  BuildContext context, {
  required DateTime monthDate,
  required DateTime nowTime,
  required void Function(bool) switchMonth,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () => switchMonth(true),
            icon: const Icon(Icons.chevron_left)),
        Material(
          borderRadius: BorderRadius.circular(100),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(100),
            child: Ink(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).colorScheme.surface),
              child: Text(
                DateFormat('yyyy年MM月').format(monthDate),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: monthDate.year == nowTime.year &&
                    monthDate.month == nowTime.month
                ? null
                : () => switchMonth(false),
            icon: const Icon(Icons.chevron_right)),
      ],
    ),
  );
}

Widget _thisMonth(
  BuildContext context, {
  required int month,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    child: Text(
      '$month月',
      style: Theme.of(context).textTheme.subtitle2,
    ),
  );
}

Widget _weekItem(BuildContext context, {required String week}) {
  return Expanded(
    flex: 1,
    child: Text(
      week,
      style: Theme.of(context).textTheme.caption,
      textAlign: TextAlign.center,
    ),
  );
}

Widget _week(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _weekItem(context, week: '日'),
      const SizedBox(
        width: 12,
      ),
      _weekItem(context, week: '一'),
      const SizedBox(
        width: 12,
      ),
      _weekItem(context, week: '二'),
      const SizedBox(
        width: 12,
      ),
      _weekItem(context, week: '三'),
      const SizedBox(
        width: 12,
      ),
      _weekItem(context, week: '四'),
      const SizedBox(
        width: 12,
      ),
      _weekItem(context, week: '五'),
      const SizedBox(
        width: 12,
      ),
      _weekItem(context, week: '六'),
    ],
  );
}

Widget _day(
  BuildContext context, {
  int? day,
  bool isThisMonth = true,
  bool isToday = false,
  bool isDone = false,
}) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: isToday ? Theme.of(context).colorScheme.surface : null,
      border: isDone
          ? Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 2.0,
            )
          : null,
      shape: BoxShape.circle,
    ),
    child: Text(
      '${day ?? ''}',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.5,
        height: 0.77,
        color: isThisMonth
            ? Theme.of(context).textTheme.bodyText1?.color
            : Theme.of(context).colorScheme.outline,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
