import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monitoring_project/app/modules/dashboard/constants/constants.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.tap,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback tap;

  // Define a constant for fontSize or make it a variable
  static const double _fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tap,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(svgSrc, color: grey, height: 20),
      title: Text(
        title,
        style: TextStyle(color: grey, fontSize: _fontSize),
      ),
    );
  }
}

