import 'package:flutter/material.dart';
import 'package:monitoring_project/app/modules/dashboard/constants/constants.dart';
import 'package:monitoring_project/app/modules/dashboard/screens/components/radial_painter.dart';

class humidity extends StatelessWidget {
  final double humidityValue; // Assume this is the current humidity

  const humidity({Key? key, required this.humidityValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate percentage based on humidity value (adjust this based on your specific use case)
    double percentage = humidityValue / 100.0;

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
              'Humidity',
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 230,
              width: double.infinity, // Ensure the width takes the full available space
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                  bgColor: textColor.withOpacity(0.1),
                  lineColor: primaryColor,
                  percent: percentage, // Use the calculated percentage
                  width: 18.0,
                ),
                child: Center(
                  child: Text(
                    '$humidityValue%',
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
