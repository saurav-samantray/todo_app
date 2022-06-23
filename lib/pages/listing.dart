import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/widget/todo_list_container.dart';

import '../widget/appbar_widget.dart';

class ListingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListingPageState();

}

class _ListingPageState extends State<ListingPage> {

  void refresh() {
    log.d("Refresh Listing page");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
        child: Builder(
            builder: (context) {
                return Scaffold(
                  body: ToDoListContainer(notifyParent: refresh,),
                );
              }
            ));
  }

}