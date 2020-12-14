import 'package:flash_chat/router.dart' as router;
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.routeName,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
