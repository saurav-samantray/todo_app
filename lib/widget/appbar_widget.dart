import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../themes.dart';

AppBar buildAppBar(BuildContext context, String title) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  themeSwitcher() => ThemeSwitcher(
    builder: (context) => IconButton(
      icon: Icon(CupertinoIcons.moon_stars, color: Theme.of(context).primaryColor,),
      onPressed: () {
        log.i("isDarkMode $isDarkMode");
        final theme = isDarkMode ? JTThemes.lightTheme : JTThemes.darkTheme;
        final switcher = ThemeSwitcher.of(context);
        switcher.changeTheme(theme: theme);
      },
    ),
  );

  return AppBar(
    //leading: BackButton(),
    leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios, color: JTThemes.primaryColor,)
    ),
    backgroundColor: Theme.of(context).backgroundColor,
    elevation: 0,
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w600,
      ),
    ),
    actions: [
      themeSwitcher()
    ],
  );
}