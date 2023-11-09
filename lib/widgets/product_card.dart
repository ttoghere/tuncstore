import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuncstore/blocs/cart/cart_bloc.dart';
import 'package:tuncstore/blocs/wishlist/wishlist_bloc.dart';
import 'package:tuncstore/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double widthFactor;
  final bool additionalButtons;

  const ProductCard({
    Key? key,
    required this.product,
    this.widthFactor = 2.25,
    this.additionalButtons = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthValue = MediaQuery.of(context).size.width / widthFactor;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: product,
        );
      },
      child: Stack(
        children: <Widget>[
          SizedBox(
            width: widthValue,
            height: 150,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 60,
            left: 5,
            child: Container(
              width: widthValue - 10,
              height: 80,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(50),
              ),
            ),
          ),
          Positioned(
            top: 65,
            left: 10,
            child: Container(
              width: widthValue - 10,
              height: 70,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        Text(
                          '\$${product.price}',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            final snackBar = const SnackBar(
                              content: Text('Added to your Cart!'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            context.read<CartBloc>().add(
                                  AddProduct(product),
                                );
                          },
                        ),
                        additionalButtons
                            ? IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  final snackBar = const SnackBar(
                                    content:
                                        Text('Removed from your Wishlist!'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  context
                                      .read<WishlistBloc>()
                                      .add(RemoveProductFromWishlist(product));
                                },
                              )
                            : const SizedBox()
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
