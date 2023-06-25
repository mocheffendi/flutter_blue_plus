import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class StatisticsTab extends StatelessWidget {
  const StatisticsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Statistics",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const Icon(
          IconlyLight.chart,
          size: 40,
        ),
      ],
    );
  }
}
