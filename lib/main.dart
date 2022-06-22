import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:todo_app/pages/home.dart';
import 'package:todo_app/pages/intro.dart';
import 'package:todo_app/pages/login.dart';
import 'package:todo_app/themes.dart';
import 'package:todo_app/utils/user_preferences.dart';


final Logger log = Logger();
void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  ToDoApp({Key? key}) : super(key: key);

  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => const LoginPage(),
    IntroPage.tag: (context) => const IntroPage(),
    HomePage.tag: (context) => const HomePage(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    const user = UserPreferences.cpUser;

    return ThemeProvider(
        initTheme: user.isDarkMode ? JTThemes.darkTheme : JTThemes.lightTheme,
        child: MaterialApp(
          title: 'CultrPlus',
          debugShowCheckedModeBanner: false,
          // theme: ThemeData(
          //   primaryColor: const Color(0xFF129da5),
          //   primarySwatch: MaterialColor(0xFF129da5, color),
          //   splashColor: Colors.transparent,
          //   highlightColor: Colors.transparent,
          //   hoverColor: Colors.transparent,
          //   fontFamily: 'Roboto',
          // ),
          theme: user.isDarkMode ? JTThemes.darkTheme : JTThemes.lightTheme,
          home: const IntroPage(),
          routes: routes,
        ));
  }
}
