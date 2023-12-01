import 'package:flutter/material.dart';

class DIYListScreen extends StatelessWidget {
  static const routeName = "/diylist";
  const DIYListScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const DIYListScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
