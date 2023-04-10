import 'package:flutter/material.dart';

import '../../models/enum/months_info.dart';
import '../../resources/colors.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late int selectedMonth;
  late int selectedYear;

  @override
  void initState() {
    DateTime today = DateTime.now();
    selectedMonth = today.month;
    selectedYear = today.year;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedMonth == 1) {
                    selectedMonth = 12;
                    selectedYear--;
                  } else {
                    selectedMonth--;
                  }
                });
              },
              child: const Icon(Icons.arrow_back_ios, size: 20.0),
            ),
            Text(
              '${MonthsInfo.getMonthByOrder(selectedMonth).fullName} $selectedYear',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Colors.black),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedMonth == 12) {
                    selectedMonth = 1;
                    selectedYear++;
                  } else {
                    selectedMonth++;
                  }
                });
              },
              child: const Icon(Icons.arrow_forward_ios, size: 20.0),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          childAspectRatio: 1.5,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ..._buildWeekdays(),
            ..._buildPrevMonthsDays(),
            ..._buildDays(),
            ..._buildPostMonthsDays(),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildWeekdays() {
    return [
      _buildSingleWeekday('M'),
      _buildSingleWeekday('T'),
      _buildSingleWeekday('W'),
      _buildSingleWeekday('T'),
      _buildSingleWeekday('F'),
      _buildSingleWeekday('S', true),
      _buildSingleWeekday('S', true),
    ];
  }

  List<Widget> _buildPrevMonthsDays() {
    int dayOfWeek = DateTime.utc(selectedYear, selectedMonth).weekday;
    if (dayOfWeek != 1) {
      int month = selectedMonth;
      int year = selectedYear;
      if (month == 1) {
        month = 12;
        year--;
      } else {
        month--;
      }
      int days = MonthsInfo.getMonthByOrder(month).getDays(year);
      return List.generate(days, (index) => _buildSingleDay(++index, true))
          .sublist(days - dayOfWeek + 1);
    }
    return [];
  }

  List<Widget> _buildDays() {
    int daysQuantity =
        MonthsInfo.getMonthByOrder(selectedMonth).getDays(selectedYear);
    return List.generate(daysQuantity, (index) => _buildSingleDay(++index));
  }

  List<Widget> _buildPostMonthsDays() {
    int daysQuantity =
        MonthsInfo.getMonthByOrder(selectedMonth).getDays(selectedYear);
    int dayOfWeek =
        DateTime.utc(selectedYear, selectedMonth, daysQuantity).weekday;
    if (dayOfWeek != 7) {
      return List.generate(
          7 - dayOfWeek, (index) => _buildSingleDay(++index, true));
    }
    return [];
  }

  Widget _buildSingleWeekday(String text, [bool isWeekend = false]) {
    return Center(
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: isWeekend ? neonRed : Colors.black),
      ),
    );
  }

  Widget _buildSingleDay(int dayNum, [bool isAnotherMonth = false]) {
    return Center(
      child: Text(
        dayNum.toString(),
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: isAnotherMonth ? Colors.grey : Colors.black),
      ),
    );
  }
}
