import 'package:flutter/material.dart';

import '../view/event_creation_screen/event_creation_screen.dart';
import '../view/login_screen/login_screen.dart';
import '../view/navigation_screen/navigation_screen.dart';
import '../view/registration_screen/registration_screen.dart';
import '../view/splash_screen/splash_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return SplashScreen.getRoute();
      case NavigationScreen.routeName:
        return NavigationScreen.getRoute();
      case LoginScreen.routeName:
        return LoginScreen.getRoute();
      case RegistrationScreen.routeName:
        return RegistrationScreen.getRoute();
      case EventCreationScreen.routeName:
        return EventCreationScreen.getRoute();
      default:
        return LoginScreen.getRoute();
    }
  }
}
