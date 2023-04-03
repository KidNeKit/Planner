import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../blocs/day_plans/day_plans_bloc.dart';
import '../../../models/enum/operation_status.dart';

class DayPlansViewList extends StatelessWidget {
  const DayPlansViewList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayPlansBloc, DayPlansState>(
      builder: (context, state) {
        if (state.status == OperationStatus.loading ||
            state.status == OperationStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // } else if (state.status == OperationStatus.failed) {
        //   return Center(
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Icon(Icons.circle_outlined),
        //         Text('Try again'),
        //       ],
        //     ),
        //   );
        // }
        return ListView.separated(
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) => const ListViewItem(),
            separatorBuilder: (context, index) => const SizedBox(height: 15.0),
            itemCount: 4);
      },
    );
  }
}

class ListViewItem extends StatelessWidget {
  const ListViewItem({super.key});

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
                        .copyWith(top: 15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: CardBody(
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
        ],
      );
    });
  }
}

class CardBody extends StatelessWidget {
  final double cardHeight;
  const CardBody({required this.cardHeight, super.key});

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
              'Today - 12:45 pm',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.black),
            ),
            const Spacer(),
            CircularPercentIndicator(
              radius: 1 / 6.5 * cardHeight,
              percent: 0.75,
              progressColor: const Color(0xFF77E6B6),
              backgroundColor: const Color(0xFFD7ECF1),
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                '75%',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7.0),
        Text(
          'Event label',
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.black),
        ),
        const Spacer(),
        const Divider(),
        const SizedBox(height: 5.0),
        Row(
          children: [
            Container(
              height: 1 / 5 * cardHeight,
              width: 1 / 5 * cardHeight,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              'Friend name',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.black),
            ),
            const Spacer(),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xFFA880E3).withOpacity(0.15),
                border:
                    Border.all(color: const Color(0xFFA880E3).withOpacity(0.7)),
              ),
              child: Text(
                'IN PROGRESS',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: const Color(0xFFA880E3)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
