import 'package:flutter/material.dart';

class HomeCards extends StatelessWidget {
  const HomeCards({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        var cardSide = 0.47 * constraints.maxWidth;
        var spacerWidth = constraints.maxWidth - 2 * cardSide;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: constraints.maxWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardItem(cardSide: cardSide),
                  CardItem(cardSide: cardSide),
                ],
              ),
            ),
            SizedBox(height: spacerWidth),
            SizedBox(
              width: constraints.maxWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardItem(cardSide: cardSide),
                  CardItem(cardSide: cardSide),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class CardItem extends StatelessWidget {
  final double cardSide;
  final Function()? onPressedFunc;

  const CardItem({required this.cardSide, this.onPressedFunc, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressedFunc,
      child: Container(
        height: cardSide,
        width: cardSide,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4E568C).withOpacity(0.08),
              blurRadius: 20.0,
              offset: const Offset(0, 20.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [],
        ),
      ),
    );
  }
}
