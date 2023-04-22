import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../domain/entities/event_entity.dart';

class DayPlansViewTable extends StatefulWidget {
  static const int hoursCount = 24;
  static const double numberWidthCoef = 0.15;
  static const double freeWidthCoef = 0.85;

  final List<EventEntity> _events;

  const DayPlansViewTable({required List<EventEntity> events, super.key})
      : _events = events;

  @override
  State<DayPlansViewTable> createState() => _DayPlansViewTableState();
}

class _DayPlansViewTableState extends State<DayPlansViewTable> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
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
                    var minutes = e.endDate.difference(e.startDate).inMinutes;
                    return EventContainer(
                        hours: e.startDate.hour,
                        minutes: e.startDate.minute,
                        offsetHeight: hourHeight,
                        containerHeight: minutes / 60 * hourHeight,
                        containerWidth: hourWidth);
                  }).toList(),
                  _buildTimeLine(hourWidth, hourHeight, context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimeLine(
      double hourWidth, double hourHeight, BuildContext context) {
    var now = DateTime.now();
    var offset = now.hour + now.minute / 60;
    return Positioned(
      top: offset * hourHeight,
      child: Container(
        height: 2,
        width: hourWidth,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
  final double offsetHeight;
  final double containerHeight;
  final double containerWidth;
  const EventContainer(
      {required this.hours,
      required this.minutes,
      required this.offsetHeight,
      required this.containerHeight,
      required this.containerWidth,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: hours * offsetHeight + minutes / 60 * offsetHeight,
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
