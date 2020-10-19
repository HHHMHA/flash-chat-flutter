import 'package:flash_chat/router.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/login_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: LoginScreen.ROUTE_NAME,
      onGenerateRoute: Router.generateRoute,
    );
  }
}
