import 'package:flutter/material.dart';
import 'package:tuncstore/screens/diy/diy_list_screen.dart';
import 'package:tuncstore/screens/screens.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        color: Colors.black,
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(DIYListScreen.routeName);
        },
        icon: const Icon(Icons.list),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {
            Navigator.pushNamed(
              context,
              WishlistScreen.routeName,
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
