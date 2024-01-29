import 'dart:math';
import 'package:flutter/material.dart';
import 'package:monitoring_project/app/modules/dashboard/constants/constants.dart';
import 'package:monitoring_project/app/modules/dashboard/screens/components/radial_painter.dart';

class moisture_content extends StatelessWidget {
  final double temperatureValue;
  final double humidityValue;

  moisture_content(
      {Key? key, required this.temperatureValue, required this.humidityValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate moisture content value based on the Oswins equation

    const double OswinA = 0.1;
    const double OswinC = 0.05;

    double exponent = OswinA * temperatureValue;
    double hue = humidityValue / 100;
    double denominator = ((1 - hue) * exp(exponent)) + 1;
    double value = (OswinC * exp(exponent)) / denominator;
    double moistureValue = value * 100;

    double percent = moistureValue / 100;

    return Padding(
      padding: const EdgeInsets.only(top: appPadding),
      child: Container(
        height: 350,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Moisture Content',
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 230,
              width: double
                  .infinity, // Ensure the width takes the full available space
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                  bgColor: textColor.withOpacity(0.1),
                  lineColor: primaryColor,
                  percent: percent, // Use the calculated percentage
                  width: 18.0,
                ),
                child: Center(
                  child: Text(
                    '${moistureValue.toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
