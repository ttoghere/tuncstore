import 'package:flutter/material.dart';

class DIYDetailsScreen extends StatelessWidget {
  static const routeName = "/diydetails";
  const DIYDetailsScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const DIYDetailsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
