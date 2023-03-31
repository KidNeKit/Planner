import 'package:flutter/material.dart';

import '../../global_components/custom_text_sizes.dart';

class DayPlansViewSelector extends StatelessWidget {
  const DayPlansViewSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: const EdgeInsets.all(15.0).copyWith(bottom: 0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: LayoutBuilder(builder: (ctx, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Stack(
              children: [
                Container(
                  width: constraints.maxWidth / 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: constraints.maxWidth / 2,
                      child: const Center(
                        child: CustomLabelLargeText(
                            text: 'Table view', color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth / 2,
                      child: const Center(
                        child: CustomLabelLargeText(
                            text: 'ListView', color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
