import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '/blocs/blocs.dart';
import '/models/models.dart';
import '/repositories/checkout/checkout_repository.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final AuthBloc _authBloc;
  final CartBloc _cartBloc;
  final PaymentBloc _paymentBloc;
  final CheckoutRepository _checkoutRepository;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _paymentSubscription;
  StreamSubscription? _checkoutSubscription;
  StreamSubscription? _authSubscription;

  CheckoutBloc({
    required AuthBloc authBloc,
    required CartBloc cartBloc,
    required PaymentBloc paymentBloc,
    required CheckoutRepository checkoutRepository,
  })  : _cartBloc = cartBloc,
        _paymentBloc = paymentBloc,
        _checkoutRepository = checkoutRepository,
        _authBloc = authBloc,
        super(
          cartBloc.state is CartLoaded
              ? CheckoutLoaded(
                  checkout: Checkout(
                    user: authBloc.state.user,
                    cart: (cartBloc.state as CartLoaded).cart,
                  ),
                )
              : CheckoutLoading(),
        ) {
    on<UpdateCheckout>(_onUpdateCheckout);
    on<ConfirmCheckout>(_onConfirmCheckout);

    _cartSubscription = _cartBloc.stream.listen(
      (state) {
        if (state is CartLoaded) {
          Checkout checkout = (this.state as CheckoutLoaded)
              .checkout
              .copyWith(cart: state.cart);
          add(UpdateCheckout(checkout));
        }
      },
    );
    _authSubscription = _authBloc.stream.listen(
      (state) {
        if (state.status == AuthStatus.unauthenticated) {
          Checkout checkout = (this.state as CheckoutLoaded)
              .checkout
              .copyWith(user: User.empty);
          add(UpdateCheckout(checkout));
        } else {
          Checkout checkout = (this.state as CheckoutLoaded)
              .checkout
              .copyWith(user: state.user);
          add(UpdateCheckout(checkout));
        }
      },
    );

    // _paymentSubscription = _paymentBloc.stream.listen((state) {
    //   if (state is PaymentLoaded) {
    //     add(
    //       UpdateCheckout(paymentMethod: state.paymentMethod),
    //     );
    //   }
    // });
  }

  void _onUpdateCheckout(
    UpdateCheckout event,
    Emitter<CheckoutState> emit,
  ) {
    if (state is CheckoutLoaded) {
      emit(
        CheckoutLoaded(checkout: event.checkout),
      );
    }
  }

  void _onConfirmCheckout(
    ConfirmCheckout event,
    Emitter<CheckoutState> emit,
  ) async {
    _checkoutSubscription?.cancel();
    if (state is CheckoutLoaded) {
      try {
        await _checkoutRepository.addCheckout(event.checkout);
        log('Done');
        emit(CheckoutLoading());
      } catch (_) {}
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    _paymentSubscription?.cancel();
    _cartSubscription?.cancel();
    return super.close();
  }
}
