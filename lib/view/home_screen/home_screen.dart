import 'package:flutter/material.dart';

import 'components/home_background.dart';
import 'components/home_body.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          HomeBackground(),
          HomeBody(),
        ],
      ),
    );
  }
}
