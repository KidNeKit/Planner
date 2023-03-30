import 'package:flutter/material.dart';

import '../view/navigation_screen/navigation_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationScreen.routeName:
        return NavigationScreen.getRoute();
      default:
        return MaterialPageRoute(
            builder: (context) => const NavigationScreen());
    }
  }
}
