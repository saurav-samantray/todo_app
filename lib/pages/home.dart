import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/pages/create.dart';
import 'package:todo_app/pages/listing.dart';
import 'package:todo_app/pages/profile.dart';
import 'package:todo_app/widget/appbar_widget.dart';

import 'dashboard.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  final pages = [
    DashboardPage(),
    ListingPage(),
    CreatePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {

    Future<bool> _onBackPressed() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to exit CultrPlus?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('NO'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: const Text('YES'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          }).then((value) => value ?? false);
    }

    Container buildCPNavBar(BuildContext context) {
      return Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: pageIndex == 0
                  ? const Icon(
                Icons.dashboard,
                color: Colors.white,
                size: 35,
              )
                  : const Icon(
                Icons.dashboard_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? const Icon(
                Icons.list_alt,
                color: Colors.white,
                size: 35,
              )
                  : const Icon(
                Icons.list_alt_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? const Icon(
                Icons.add,
                color: Colors.white,
                size: 35,
              )
                  : const Icon(
                Icons.add,
                color: Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              icon: pageIndex == 3
                  ? const Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 35,
              )
                  : const Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],
        ),
      );
    }

    return ThemeSwitchingArea(
        child: Builder(
            builder: (context) => WillPopScope(
              onWillPop: _onBackPressed,
              child: Scaffold(
                appBar: buildAppBar(context, ""),
                // appBar: AppBar(
                //   leading: IconButton(
                //       onPressed: () => Navigator.of(context).pop(),
                //       icon: const Icon(Icons.arrow_back_ios, color: JTThemes.primaryColor,)
                //   ),
                //   backgroundColor: JTThemes.widgetLightBackground,
                //   elevation: 0,
                // ),
                body: pages[pageIndex],
                bottomNavigationBar: buildCPNavBar(context),
              ),
            )));
  }

}