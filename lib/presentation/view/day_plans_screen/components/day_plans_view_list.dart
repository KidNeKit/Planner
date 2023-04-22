import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:planner/domain/entities/event_entity.dart';

import '../../../../domain/entities/enum/event_status.dart';

class DayPlansViewList extends StatelessWidget {
  final List<EventEntity> _events;
  const DayPlansViewList({required List<EventEntity> events, super.key})
      : _events = events;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) => ListViewItem(event: _events[index]),
        separatorBuilder: (context, index) => const SizedBox(height: 15.0),
        itemCount: _events.length);
  }
}

class ListViewItem extends StatelessWidget {
  final EventEntity event;
  const ListViewItem({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardHeight = 0.2 * size.height;
    return LayoutBuilder(builder: (ctx, constraints) {
      double cardWidth = constraints.maxWidth;
      return Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                height: cardHeight,
                width: 0.99 * cardWidth,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: CardBody(
                  event: event,
                  cardHeight: cardHeight,
                ),
              ),
            ),
          ),
          Positioned(
            top: 1 / 6 * cardHeight,
            child: Container(
              height: 2 / 3 * cardHeight,
              width: 0.02 * cardWidth,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          _buildPercentIndicator(cardHeight, context),
        ],
      );
    });
  }

  Widget _buildPercentIndicator(double cardHeight, BuildContext context) {
    double percentage;
    var now = DateTime.now();
    if (now.isBefore(event.startDate)) {
      percentage = 0;
    } else if (now.isAfter(event.endDate)) {
      percentage = 1;
    } else {
      var duration = event.endDate.difference(event.startDate).inSeconds;
      var last = now.difference(event.startDate).inSeconds;
      percentage = last / duration;
    }
    return Positioned(
      top: 10,
      right: 15,
      child: CircularPercentIndicator(
        radius: 1 / 6.5 * cardHeight,
        percent: percentage,
        progressColor: const Color(0xFF77E6B6),
        backgroundColor: const Color(0xFFD7ECF1),
        circularStrokeCap: CircularStrokeCap.round,
        center: Text(
          '${(100 * percentage).toInt()}%',
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class CardBody extends StatelessWidget {
  final EventEntity event;
  final double cardHeight;
  const CardBody({required this.event, required this.cardHeight, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.access_time),
            const SizedBox(width: 7.0),
            Text(
              '${event.startDate.hour < 10 ? '0' : ''}${event.startDate.hour}:${event.startDate.minute < 10 ? '0' : ''}${event.startDate.minute} - ${event.endDate.hour < 10 ? '0' : ''}${event.endDate.hour}:${event.endDate.minute < 10 ? '0' : ''}${event.endDate.minute}',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.black),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 5.0),
        Row(
          children: [
            Expanded(
              child: Text(
                event.eventName,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
        Text(
          event.eventLocation,
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.fade,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.black),
        ),
        const Spacer(),
        const Divider(),
        const SizedBox(height: 5.0),
        Row(
          children: [
            // Container(
            //   height: 1 / 5 * cardHeight,
            //   width: 1 / 5 * cardHeight,
            //   decoration: BoxDecoration(
            //     color: Colors.grey,
            //     borderRadius: BorderRadius.circular(5.0),
            //   ),
            // ),
            // const SizedBox(width: 10.0),
            // Text(
            //   'Friend name',
            //   style: Theme.of(context)
            //       .textTheme
            //       .labelMedium!
            //       .copyWith(color: Colors.black),
            //),
            const Spacer(),
            _buildEventStatus(context),
          ],
        ),
      ],
    );
  }

  Widget _buildEventStatus(BuildContext context) {
    var now = DateTime.now();
    EventStatus status;
    if (now.isAfter(event.startDate) && now.isBefore(event.endDate)) {
      status = EventStatus.inProgress;
    } else if (now.isAfter(event.endDate)) {
      status = EventStatus.completed;
    } else {
      status = EventStatus.pending;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: status.color.withOpacity(0.15),
        border: Border.all(color: status.color.withOpacity(0.7)),
      ),
      child: Text(
        status.status,
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: status.color),
      ),
    );
  }
}
