// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCheckout extends CheckoutEvent {
  final User? user;
  final Cart? cart;
  final PaymentMethod? paymentMethod;

  const UpdateCheckout({
    this.user,
    this.cart,
    this.paymentMethod,
  });

  @override
  List<Object?> get props => [
        user,
        cart,
        paymentMethod,
      ];

  UpdateCheckout copyWith({
    User? user,
    Cart? cart,
    PaymentMethod? paymentMethod,
  }) {
    return UpdateCheckout(
      user: user ?? this.user,
      cart: cart ?? this.cart,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}

class ConfirmCheckout extends CheckoutEvent {
  final Checkout checkout;

  const ConfirmCheckout({required this.checkout});

  @override
  List<Object?> get props => [checkout];
}
