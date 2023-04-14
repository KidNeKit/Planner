import 'package:flutter/material.dart';

import '../../../models/event.dart';

class DayPlansViewTable extends StatefulWidget {
  static const int hoursCount = 24;
  static const double numberWidthCoef = 0.15;
  static const double freeWidthCoef = 0.85;

  final List<Event> _events;

  const DayPlansViewTable({required List<Event> events, super.key})
      : _events = events;

  @override
  State<DayPlansViewTable> createState() => _DayPlansViewTableState();
}

class _DayPlansViewTableState extends State<DayPlansViewTable> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    //SchedulerBinding.instance.addPostFrameCallback((_) {
    //  _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    //});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        double hourWidth = constraints.maxWidth;
        double hourHeight = 0.07 * MediaQuery.of(context).size.height;
        return Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Stack(
                children: [
                  Column(
                    children: List.generate(
                        DayPlansViewTable.hoursCount,
                        (index) => HourContainer(
                              index: index,
                              hourHeight: hourHeight,
                              hourWidth: hourWidth,
                            )),
                  ),
                  Positioned(
                    left: DayPlansViewTable.numberWidthCoef * hourWidth,
                    child: Container(
                      height: DayPlansViewTable.hoursCount * hourHeight,
                      width: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  ...widget._events.map((e) {
                    return EventContainer(
                        hours: e.startDate.hour,
                        minutes: e.startDate.minute,
                        containerHeight: hourHeight,
                        containerWidth: hourWidth);
                  }).toList(),
                  //todo set top offset
                  Positioned(
                    top: 17 * hourHeight,
                    child: Container(
                      height: 2,
                      width: hourWidth,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class HourContainer extends StatelessWidget {
  final int index;
  final double hourHeight;
  final double hourWidth;
  const HourContainer(
      {required this.index,
      required this.hourHeight,
      required this.hourWidth,
      super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        double containerWidth = constraints.maxWidth;
        return Container(
          height: hourHeight,
          width: containerWidth,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  width: index != DayPlansViewTable.hoursCount - 1 ? 1 : 0,
                  color: Colors.grey.withOpacity(0.5)),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: DayPlansViewTable.numberWidthCoef * hourWidth,
                child: Center(
                  child: Text(
                    '$index',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.black.withOpacity(0.5)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class EventContainer extends StatelessWidget {
  final int hours;
  final int minutes;
  final double containerHeight;
  final double containerWidth;
  const EventContainer(
      {required this.hours,
      required this.minutes,
      required this.containerHeight,
      required this.containerWidth,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: hours * containerHeight + minutes / 60 * containerHeight,
      left: DayPlansViewTable.numberWidthCoef * containerWidth,
      child: Container(
        height: containerHeight,
        width: DayPlansViewTable.freeWidthCoef * containerWidth,
        color: Colors.amber,
        child: Center(
          child: Text(
            'Event label',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
