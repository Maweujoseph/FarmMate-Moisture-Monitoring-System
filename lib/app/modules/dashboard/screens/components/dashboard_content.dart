import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:monitoring_project/app/modules/dashboard/constants/constants.dart';
import 'package:monitoring_project/app/modules/dashboard/constants/responsive.dart';
/*import 'package:monitoring_project/app/modules/dashboard/screens/components/analytic_cards.dart';*/
import 'package:monitoring_project/app/modules/dashboard/screens/components/custom_appbar.dart';
import 'package:monitoring_project/app/modules/dashboard/screens/components/temperature.dart';
/*import 'package:monitoring_project/app/modules/dashboard/screens/components/users.dart';
import 'package:monitoring_project/app/modules/dashboard/screens/components/users_by_device.dart';*/
import 'package:monitoring_project/app/modules/dashboard/screens/components/viewers.dart';
import 'package:monitoring_project/app/modules/dashboard/screens/components/intensity.dart';
import 'package:monitoring_project/app/modules/dashboard/screens/components/humidity.dart';
import 'package:monitoring_project/app/modules/dashboard/screens/components/moisture_content.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({Key? key}) : super(key: key);

  @override
  _DashboardContentState createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  double temperatureValue = 20.00;
  double humidityValue = 15.00;

  @override
  void initState() {
    super.initState();
    setupDataListener();
  }

  void setupDataListener() {
  final reference = FirebaseDatabase.instance.ref();
  DatabaseReference dht11Ref = reference.child("DHT11");

  dht11Ref.onValue.listen((event) {
    DataSnapshot snapshot = event.snapshot;

    if (snapshot == null || snapshot.value == null) {
      return;
    }

    Map<String, dynamic>? data = snapshot.value as Map<String, dynamic>?;

    if (data == null) {
      return;
    }

    setState(() {
      temperatureValue = double.tryParse(data['Temperature']) ?? 20.0;
      humidityValue = double.tryParse(data['Humidity']) ?? 30.0;
      debugPrint("Data Updated: Temperature=$temperatureValue, Humidity=$humidityValue");
    });
  });
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(appPadding),
        child: Column(
          children: [
            const CustomAppbar(),
            const SizedBox(height: appPadding),

            // 2.  Moisture content readings
            moisture_content(
              temperatureValue: temperatureValue,
              humidityValue: humidityValue,
            ),
            const SizedBox(height: appPadding),

            // 3. UsersByDevice() - Gauges for Temperature, Humidity, and Light intensity
            Column(
              children: Responsive.isMobile(context)
                  ? [
                      temperature(temperatureValue: temperatureValue),
                      const SizedBox(height: appPadding),
                      humidity(humidityValue: humidityValue),
                      const SizedBox(height: appPadding),
                      LightIntensity(lightIntensityValue: 10),
                    ]
                  : [
                      Row(
                        children: [
                          Expanded(
                            child:
                                temperature(temperatureValue: temperatureValue),
                          ),
                          const SizedBox(width: appPadding),
                          Expanded(
                            child: humidity(humidityValue: humidityValue),
                          ),
                          const SizedBox(width: appPadding),
                          Expanded(
                            child: LightIntensity(lightIntensityValue: 10),
                          ),
                        ],
                      ),
                    ],
            ),

            const SizedBox(height: appPadding),

            // 4. Viewers
            const Viewers(),
            const SizedBox(height: appPadding),

            // 5. Recommendation Section with text input
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(appPadding),
              child: Column(
                children: [
                  Text(
                    'Recommendations',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Text input for recommendations
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Enter your recommendations...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
