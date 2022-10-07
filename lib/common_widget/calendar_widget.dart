import 'package:date_utils/date_utils.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  final bool isExpanded;
  final DateTime monthDate;

  const CalendarWidget({
    super.key,
    this.isExpanded = false,
    required this.monthDate,
  });

  @override
  State<StatefulWidget> createState() => _CalendarWidgetState();

}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _monthDate;

  @override
  void initState() {
    _monthDate = widget.monthDate;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CalendarWidget oldWidget) {
    setState(() {
      _monthDate = widget.monthDate;
    });
    super.didUpdateWidget(oldWidget);
  }

  int get startWeek {
    return DateUtils.firstDayOfMonth(_monthDate).weekday;
  }

  bool isToday(int day) {
    return _monthDate.year == DateTime.now().year &&
        _monthDate.month == DateTime.now().month &&
        _monthDate.day == day;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          firstChild: _datePicker(context, monthDate: _monthDate),
          secondChild: _thisMonth(context, month: _monthDate.month),
          crossFadeState:
              widget.isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
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
            itemCount: DateUtils.daysInMonth(_monthDate).length,
            itemBuilder: (BuildContext context, int index) {
              final DateTime day = DateUtils.daysInMonth(_monthDate)[index];
              final int actualDay = day.day;
              return _day(
                context,
                day: actualDay,
                isToday: isToday(
                  actualDay,
                ),
                isThisMonth: day.month == _monthDate.month,
              );
            },
          ),
        )
      ],
    );
  }
}

Widget _datePicker(BuildContext context, {required DateTime monthDate}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_left)),
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
        IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_right)),
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
