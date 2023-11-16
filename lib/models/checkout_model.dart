// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:tuncstore/models/models.dart';

class Checkout extends Equatable {
  final User? user;
  final List<Product>? products;
  final String? subtotal;
  final String? deliveryFee;
  final String? total;

  const Checkout({
    this.user,
    required this.products,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
  });

  @override
  List<Object?> get props => [
        user,
        products,
        subtotal,
        deliveryFee,
        total,
      ];

  Map<String, Object> toDocument() {
    return {
      'user': user?.toDocument() ?? User.empty.toDocument(),
      'products': products!.map((product) => product.name).toList(),
      'subtotal': subtotal!,
      'deliveryFee': deliveryFee!,
      'total': total!
    };
  }

  Checkout copyWith({
    User? user,
    List<Product>? products,
    String? subtotal,
    String? deliveryFee,
    String? total,
  }) {
    return Checkout(
      user: user ?? this.user,
      products: products ?? this.products,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      total: total ?? this.total,
    );
  }
}
