// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:tuncstore/models/models.dart';

class Checkout extends Equatable {
  final String? id;
  final Cart cart;
  final User? user;

  const Checkout({
    this.user,
    required this.cart,
    this.id = "",
  });

  @override
  List<Object?> get props => [
        user,
        id,
        cart,
      ];

  static Checkout fromJson(
    Map<String, dynamic> json, [
    String? id,
  ]) {
    Checkout checkout = Checkout(
      id: id ?? json['id'],
      user: User.fromJson(json['user']),
      cart: Cart.fromJson(json['cart']),
    );
    return checkout;
  }

  Map<String, Object> toDocument() {
    return {
      'user': user?.toDocument() ?? User.empty.toDocument(),
      'cart': cart.toDocument(),
    };
  }

  Checkout copyWith({
    String? id,
    User? user,
    Cart? cart,
  }) {
    return Checkout(
      id: id ?? this.id,
      user: user ?? this.user,
      cart: cart ?? this.cart,
    );
  }
}
