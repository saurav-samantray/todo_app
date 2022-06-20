import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/pages/login.dart';
import 'package:todo_app/themes.dart';

import '../main.dart';

class IntroPage extends StatefulWidget {
  static String tag = 'intro-page';
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IntroPageState();

}

final List<String> imgList = [
  'assets/intro_1.png',
  'assets/intro_2.png',
  'assets/intro_3.png',
];

class _IntroPageState extends State<IntroPage> {

  final logo = const Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 48.0,
      child: Text("Jumbo ToDo", style: TextStyle(fontSize: 40, color: JTThemes.primaryColor),),//Image(image: AssetImage('assets/logo.png')),
    ),
  );

  final forgotLabel = TextButton(
    child: const Text(
      'New to Jumbo ToDo? Sign Up',
      style: TextStyle(color: Colors.black54),
    ),
    onPressed: () {},
  );



  @override
  Widget build(BuildContext context) {
    int _current = 1;
    final CarouselController _controller = CarouselController();

    final List<Widget> imageSliders = imgList
        .map((item) => Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                //Image.network(item, fit: BoxFit.cover, width: 1000.0),
                Image(image: AssetImage(item), fit: BoxFit.cover, width: 1000.0,),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    // child: Text(
                    //   'No. ${imgList.indexOf(item)} image',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 20.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ),
                ),
              ],
            )),
      ),
    ))
        .toList();

    final introScroll = Container(
        child: CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });},
          ),
          items: imageSliders,
        ));

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith(
                  (states) => RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),)),
          padding: MaterialStateProperty.resolveWith(
                  (states) => const EdgeInsets.all(12)),
        ),
        onPressed: () => Navigator.of(context).pushNamed(LoginPage.tag),
        child: const SizedBox(width:60, child: Text("Log In", style:TextStyle(fontSize:20))),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 80,),
            introScroll,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                log.i(entry);
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 80,),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }

}