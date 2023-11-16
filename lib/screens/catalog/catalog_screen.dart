import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuncstore/blocs/blocs.dart';
import 'package:tuncstore/models/models.dart';
import 'package:tuncstore/widgets/search_box.dart';
import 'package:tuncstore/widgets/widgets.dart';

class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';

  static Route route({required Category category}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => CatalogScreen(category: category),
    );
  }

  final Category category;

  const CatalogScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: category.name),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBox(
              category: category,
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProductLoaded) {
                  final List<Product> categoryProducts = state.products
                      .where((product) => product.category == category.name)
                      .toList();
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1.15),
                    itemCount: categoryProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: ProductCard.catalog(
                          widthFactor: 2.15,
                          product: categoryProducts[index],
                        ),
                      );
                    },
                  );
                } else {
                  return const Text("Something Went Wrong");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
