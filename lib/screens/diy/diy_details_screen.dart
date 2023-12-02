// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuncstore/blocs/cart/cart_bloc.dart';

import 'package:tuncstore/models/diy_model.dart';
import 'package:tuncstore/models/models.dart';
import 'package:tuncstore/repositories/diy/diy_repository.dart';
import 'package:tuncstore/screens/screens.dart';
import 'package:tuncstore/widgets/widgets.dart';

class DIYDetailsScreen extends StatelessWidget {
  static const routeName = "/diydetails";
  const DIYDetailsScreen({
    Key? key,
    required this.diyModel,
  }) : super(key: key);
  final DIYModel diyModel;

  static Route route({required DIYModel diyModel}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => DIYDetailsScreen(
        diyModel: diyModel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: diyModel.title),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                diyModel.title,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.network(diyModel.imagePath),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    diyModel.description,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<List<Product>>(
                    future: _fetchProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Hata: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('Ürün bulunamadı.');
                      } else {
                        List<Product> products = snapshot.data!;
                        return Column(
                          children: [
                            Column(
                              children: products.map((product) {
                                return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductScreen(product: product),
                                      ),
                                    );
                                  },
                                  leading: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image.network(product.imageUrl),
                                  ),
                                  title: Text(
                                    product.name,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.shopping_bag,
                                    ),
                                    onPressed: () {
                                      context.read<CartBloc>().add(
                                            AddProduct(product),
                                          );
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  context.read<CartBloc>().add(
                                        AddProductList(products),
                                      );
                                },
                                child: const Text("Add All")),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Product>> _fetchProducts() async {
    List<Future<Product?>> futures = diyModel.steps
        .map((step) => DIYRepository().getProductById(step.toString()))
        .toList();

    List<Product?> products = await Future.wait(futures);

    //Filtering the non-null products
    List<Product> filteredProducts = products.whereType<Product>().toList();

    return filteredProducts;
  }
}
