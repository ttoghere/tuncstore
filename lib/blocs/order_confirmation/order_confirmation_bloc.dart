import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuncstore/models/checkout_model.dart';
import 'package:tuncstore/repositories/checkout/checkout_repository.dart';
import 'package:equatable/equatable.dart';

part 'order_confirmation_event.dart';
part 'order_confirmation_state.dart';

class OrderConfirmationBloc
    extends Bloc<OrderConfirmationEvent, OrderConfirmationState> {
  final CheckoutRepository _checkoutRepository;

  OrderConfirmationBloc({required CheckoutRepository checkoutRepository})
      : _checkoutRepository = checkoutRepository,
        super(OrderConfirmationLoading()) {
    on<LoadOrderConfirmation>(_onLoadOrderConfirmation);
  }

  void _onLoadOrderConfirmation(
    LoadOrderConfirmation event,
    Emitter<OrderConfirmationState> emit,
  ) async {
    Checkout checkout = await _checkoutRepository.getCheckout(event.checkoutId);
    emit(OrderConfirmationLoaded(checkout));
  }
}
