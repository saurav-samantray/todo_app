import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../api/http_service.dart';
import '../constants.dart';
import '../main.dart';
import '../themes.dart';
import '../utils/secured_storage.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  final storage = const FlutterSecureStorage();

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final SecureStorage secureStorage = SecureStorage();
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController(text: 'saurav@jumbo.com');
  final TextEditingController _passwordController = TextEditingController(text: 'Demo@123');

  @override
  Widget build(BuildContext context) {
    const logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Text("Jumbo ToDo", style: TextStyle(fontSize: 40, color: JTThemes.primaryColor),),//Image(image: AssetImage('assets/logo.png')),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is mandatory';
        }
        return null;
      },
      controller: _emailController,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is mandatory';
        }
        return null;
      },
      obscureText: true,
      controller: _passwordController,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith(
                  (states) => RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),)),
          padding: MaterialStateProperty.resolveWith(
                  (states) => const EdgeInsets.all(12)),
        ),
        onPressed: () {
          //Navigator.of(context).pushNamed(HomePage.tag);
          setState(() {
            isLoading = !isLoading;
          });
          const CircularProgressIndicator();
          //sleep(Duration(seconds: 2));
          login(_emailController.text, _passwordController.text).then((res) {
            log.d("Token ${res.token}");



            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Login successful for : ${res.email}'),
              backgroundColor: Colors.green.shade300,
            ));
            setState(() {
              isLoading = !isLoading;
            });

            //Push the token to secured storage and only on success push Tenant and then navigate
            secureStorage.writeSecureData(AUTH_TOKEN, res.token).then((token) {
                Navigator.of(context).pushNamed(HomePage.tag);
            });

          }).catchError((error){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.red.shade300,
            ));
            setState(() {
              isLoading = !isLoading;
            });
          });
        },
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            isLoading ? SizedBox(width:10, height:10,child: CircularProgressIndicator(color: Colors.white)) : SizedBox(width:10,),
            //Container(padding: EdgeInsets.only(left: 50),),
            SizedBox(width:30,),
            SizedBox(width:60, child: Text("Log In", style:TextStyle(fontSize:20))),
            SizedBox(width:30,),
            SizedBox(width:10,),
          ],
        ),
      ),
    );

    final forgotLabel = TextButton(
      child: const Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios, color: JTThemes.primaryColor,)
        ),
        backgroundColor: JTThemes.widgetLightBackground,
        elevation: 0,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            const SizedBox(height: 48.0),
            email,
            const SizedBox(height: 8.0),
            password,
            const SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}
