import 'package:bottom_bar/widget/sensor_card.dart';
import 'package:bottom_bar/widget/sensor_temp_circular.dart';
import 'package:flutter/material.dart';

import '../widget/sensor_humi_circular.dart';

class SensorView extends StatefulWidget {
  const SensorView({
    Key? key,
  }) : super(key: key);

  @override
  State<SensorView> createState() => _SensorViewState();
}

class _SensorViewState extends State<SensorView> {
  final double _temp = 36;
  final double _humidity = 60;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SensorCard(
              humidity: _humidity,
              temperature: _temp,
            ),
            const SensorCard(
              humidity: 80,
              temperature: 36.5,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SensorTempCircular(temperature: _temp),
            const SensorHumiCircular(humidity: 80),
          ],
        )
      ],
    );
  }
}
