import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuncstore/blocs/blocs.dart';
import 'package:tuncstore/models/models.dart';
import 'package:tuncstore/screens/order_confirmation/order_confirmation_screen.dart';
import 'package:tuncstore/screens/screens.dart';
import 'package:tuncstore/widgets/apple_pay.dart';
import 'package:tuncstore/widgets/google_pay.dart';

class CustomNavBar extends StatelessWidget {
  final String screen;
  final Product? product;

  const CustomNavBar({
    Key? key,
    required this.screen,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _selectNavBar(context, screen)!,
        ),
      ),
    );
  }

  List<Widget>? _selectNavBar(context, screen) {
    switch (screen) {
      case HomeScreen.routeName:
        return _buildNavBar(context);
      case CatalogScreen.routeName:
        return _buildNavBar(context);
      case WishlistScreen.routeName:
        return _buildNavBar(context);
      case ProductScreen.routeName:
        return _buildAddToCartNavBar(context, product);
      case CartScreen.routeName:
        return _buildGoToCheckoutNavBar(context);
      case CheckoutScreen.routeName:
        return _buildOrderNowNavBar(context);
      case OrderConfirmation.routeName:
        return _buildNavBar(context);
      case PaymentSelection.routeName:
        return _buildOrderNowNavBar(context);
      default:
        _buildNavBar(context);
    }
    return null;
  }

  List<Widget> _buildOrderNowNavBar(context) {
    return [
      BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CheckoutLoaded) {
            if (Platform.isAndroid) {
              switch (state.paymentMethod) {
                case PaymentMethod.google_pay:
                  return GooglePay(
                    products: state.products!,
                    total: state.total!,
                  );
                case PaymentMethod.credit_card:
                  return Text(
                    'Pay with Credit Card',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.white),
                  );
                default:
                  return GooglePay(
                    products: state.products!,
                    total: state.total!,
                  );
              }
            }
            if (Platform.isIOS) {
              switch (state.paymentMethod) {
                case PaymentMethod.apple_pay:
                  return ApplePay(
                    products: state.products!,
                    total: state.total!,
                  );
                case PaymentMethod.credit_card:
                  return Container();
                default:
                  return ApplePay(
                    products: state.products!,
                    total: state.total!,
                  );
              }
            } else {
              return ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/payment-selection');
                },
                child: Text(
                  'CHOOSE PAYMENT',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              );
            }
          } else {
            return const Text('Something went wrong');
          }
        },
      )
    ];
  }

  List<Widget> _buildNavBar(context) {
    return [
      IconButton(
        icon: const Icon(Icons.home, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
      ),
      IconButton(
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
      ),
      IconButton(
        icon: const Icon(Icons.person, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, '/user');
        },
      )
    ];
  }

  List<Widget> _buildAddToCartNavBar(context, product) {
    return [
      IconButton(
        icon: const Icon(Icons.share, color: Colors.white),
        onPressed: () {},
      ),
      BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const CircularProgressIndicator();
          }
          if (state is WishlistLoaded) {
            return IconButton(
              icon: const Icon(Icons.favorite, color: Colors.white),
              onPressed: () {
                const snackBar =
                    SnackBar(content: Text('Added to your Wishlist!'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                context.read<WishlistBloc>().add(AddProductToWishlist(product));
              },
            );
          }
          return const Text('Something went wrong!');
        },
      ),
      BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const CircularProgressIndicator();
          }
          if (state is CartLoaded) {
            return ElevatedButton(
              onPressed: () {
                context.read<CartBloc>().add(AddProduct(product));
                Navigator.pushNamed(context, '/cart');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(),
              ),
              child: Text(
                'ADD TO CART',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            );
          }
          return const Text('Something went wrong!');
        },
      )
    ];
  }

  List<Widget> _buildGoToCheckoutNavBar(context) {
    return [
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/checkout');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(),
        ),
        child: Text(
          'GO TO CHECKOUT',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      )
    ];
  }
}
