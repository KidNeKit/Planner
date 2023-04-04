import 'dart:developer';

import 'package:flutter/material.dart';

import '../view/login_screen/login_screen.dart';
import '../view/navigation_screen/navigation_screen.dart';
import '../view/registration_screen/registration_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationScreen.routeName:
        return NavigationScreen.getRoute();
      case LoginScreen.routeName:
        return LoginScreen.getRoute();
      case RegistrationScreen.routeName:
        return RegistrationScreen.getRoute();
      default:
        return LoginScreen.getRoute();
    }
  }
}
