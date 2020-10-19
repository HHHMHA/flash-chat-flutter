import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class Router {
  Router._();

  static Route<dynamic> generateRoute( RouteSettings settings ) {
    String screenName = settings.name;

    switch( screenName ) {
      case LoginScreen.ROUTE_NAME: return MaterialPageRoute( builder: (context) => LoginScreen() );
      case WelcomeScreen.ROUTE_NAME: return MaterialPageRoute( builder: (context) => WelcomeScreen() );
      case ChatScreen.ROUTE_NAME: return MaterialPageRoute( builder: (context) => ChatScreen() );
      case RegistrationScreen.ROUTE_NAME: return MaterialPageRoute( builder: (context) => RegistrationScreen() );
      default: return MaterialPageRoute( builder: (context) => LoginScreen() );
    }
  }
}