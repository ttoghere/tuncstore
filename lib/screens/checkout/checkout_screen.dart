// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tuncstore/blocs/blocs.dart';
import 'package:tuncstore/models/models.dart';
import 'package:tuncstore/widgets/widgets.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  const CheckoutScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const CheckoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CheckoutLoaded) {
            var user = state.user ?? User.empty;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CUSTOMER INFORMATION',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    CustomTextFormField(
                      title: 'Email',
                      initialValue: user.email,
                      onChanged: (value) {
                        context.read<CheckoutBloc>().add(
                              UpdateCheckout(
                                user:
                                    state.checkout.user!.copyWith(email: value),
                              ),
                            );
                      },
                    ),
                    CustomTextFormField(
                      title: 'Full Name',
                      initialValue: user.fullName,
                      onChanged: (value) {
                        context.read<CheckoutBloc>().add(
                              UpdateCheckout(
                                user: state.checkout.user!
                                    .copyWith(fullName: value),
                              ),
                            );
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'DELIVERY INFORMATION',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    CustomTextFormField(
                      title: 'Address',
                      initialValue: user.address,
                      onChanged: (value) {
                        context.read<CheckoutBloc>().add(
                              UpdateCheckout(
                                user: state.checkout.user!
                                    .copyWith(address: value),
                              ),
                            );
                      },
                    ),
                    CustomTextFormField(
                      title: 'City',
                      initialValue: user.city,
                      onChanged: (value) {
                        context.read<CheckoutBloc>().add(
                              UpdateCheckout(
                                user:
                                    state.checkout.user!.copyWith(city: value),
                              ),
                            );
                      },
                    ),
                    CustomTextFormField(
                      title: 'Country',
                      initialValue: user.country,
                      onChanged: (value) {
                        context.read<CheckoutBloc>().add(
                              UpdateCheckout(
                                user: state.checkout.user!
                                    .copyWith(country: value),
                              ),
                            );
                      },
                    ),
                    CustomTextFormField(
                      title: 'ZIP Code',
                      initialValue: user.zipCode,
                      onChanged: (value) {
                        context.read<CheckoutBloc>().add(
                              UpdateCheckout(
                                user: state.checkout.user!
                                    .copyWith(zipCode: value),
                              ),
                            );
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 60,
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(color: Colors.black),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/payment-selection',
                                );
                              },
                              child: Text(
                                'SELECT A PAYMENT METHOD',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'ORDER SUMMARY',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const OrderSummary()
                  ],
                ),
              ),
            );
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
    );
  }
}
