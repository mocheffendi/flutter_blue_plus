import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SensorCard extends StatefulWidget {
  final double? temperature;
  final double? humidity;

  const SensorCard({super.key, this.temperature, this.humidity});

  @override
  State<SensorCard> createState() => _SensorCardState();
}

class _SensorCardState extends State<SensorCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const RadialGradient(
              colors: [
                Color.fromARGB(255, 41, 16, 132),
                Color.fromARGB(255, 252, 39, 127),
                Color.fromARGB(255, 212, 58, 11),
              ],
              center: Alignment(1, 1),
              focal: Alignment(0.3, -0.1),
              focalRadius: 1.0)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.black87, borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  const SizedBox(height: 40),
                  Text(widget.temperature.toString(),
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24)),
                  const SizedBox(width: 10),
                  Text(widget.humidity.toString(),
                      style: GoogleFonts.lato(color: Colors.white))
                ]))),
      ),
    );
  }
}
