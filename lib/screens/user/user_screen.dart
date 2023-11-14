import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  static const routeName = "/user";
  const UserScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const UserScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
