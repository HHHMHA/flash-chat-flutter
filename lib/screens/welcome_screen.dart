import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/widgets/buttons/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  static const double logoMaxHeight = 60.0;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      upperBound: logoMaxHeight,
    );

    animationController.forward();
    animationController.addListener(() {
      setState(() {}); // rebuild the screen to apply changes
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: kLogoAnimationTag,
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animationController.value,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: "Login",
              color: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
            ),
            RoundedButton(
              title: 'Register',
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}