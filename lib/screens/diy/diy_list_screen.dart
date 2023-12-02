import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuncstore/blocs/diy/diy_bloc.dart';
import 'package:tuncstore/screens/diy/diy_details_screen.dart';
import 'package:tuncstore/widgets/widgets.dart';

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
    return Scaffold(
      appBar: const CustomAppBar(
        title: "DIY List",
      ),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: BlocBuilder<DiyBloc, DiyState>(
        builder: (context, state) {
          if (state is DiyLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DiyLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: state.diyModel
                    .map(
                      (e) => ListTile(
                        title: Text(e.title),
                        leading: Image.network(e.imagePath),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              DIYDetailsScreen.routeName,
                              arguments: e);
                        },
                      ),
                    )
                    .toList(),
              ),
            );
          } else {
            return const Center(
              child: Text("Something Went Wrong"),
            );
          }
        },
      ),
    );
  }
}
