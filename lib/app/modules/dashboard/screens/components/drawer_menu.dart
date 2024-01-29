import 'package:flutter/material.dart';
import 'package:monitoring_project/app/modules/dashboard/constants/constants.dart';
import 'package:monitoring_project/app/modules/dashboard/screens/components/drawer_list_tile.dart';
import 'package:monitoring_project/app/modules/welcome/views/welcome_view.dart';
class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(appPadding),
            child: Image.asset("assets/images/logowithtext.png"),
          
          ),
          DrawerListTile(
              title: 'Dash Board',
              svgSrc: 'assets/icons/Dashboard.svg',
              tap: () {
                print('You Click Dash Board');
              }),
         
          DrawerListTile(
              title: 'Message', svgSrc: 'assets/icons/Message.svg', tap: () {}),
          DrawerListTile(
              title: 'Statistics',
              svgSrc: 'assets/icons/Statistics.svg',
              tap: () {}),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: appPadding * 2),
            child: Divider(
              color: grey,
              thickness: 0.2,
            ),
          ),
          DrawerListTile(
              title: 'Settings',
              svgSrc: 'assets/icons/Setting.svg',
              tap: () {}),
          DrawerListTile(
              title: 'Logout', svgSrc: 'assets/icons/Logout.svg', 
              tap: () {
                _handleLogoutTap(context);
              }),
        ],
      ),
    );
  }

  void _handleLogoutTap(BuildContext context) {
  // Perform logout actions here if needed
  // ...

  // Navigate to the WelcomeView widget
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => WelcomeView()),
    (route) => false,
  );
}
}
