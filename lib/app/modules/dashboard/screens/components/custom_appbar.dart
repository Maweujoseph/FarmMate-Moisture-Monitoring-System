import 'package:flutter/material.dart';
import 'package:monitoring_project/app/modules/dashboard/constants/constants.dart';
import 'package:monitoring_project/app/modules/dashboard/constants/responsive.dart';
import 'package:monitoring_project/app/modules/dashboard/controllers/controller.dart';
import 'package:monitoring_project/app/modules/dashboard/screens/components/profile_info.dart';
import 'package:monitoring_project/app/modules/dashboard/screens/components/search_field.dart';
import 'package:provider/provider.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            onPressed: context.read<Controller>().controlMenu,
            icon: Icon(Icons.menu,color: textColor.withOpacity(0.5),),
          ),
        Expanded(child: SearchField()),
        ProfileInfo()
      ],
    );
  }
}