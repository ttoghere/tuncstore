import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuncstore/models/models.dart';
import 'package:tuncstore/repositories/checkout/base_checkout_repository.dart';

class CheckoutRepository extends BaseCheckoutRepository {
  final FirebaseFirestore _firebaseFirestore;

  CheckoutRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addCheckout(Checkout checkout) {
    return _firebaseFirestore.collection('checkout').add(checkout.toDocument());
  }

  @override
  Future<Checkout> getCheckout(String checkoutId) async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _firebaseFirestore.collection('checkout').doc(checkoutId).get();

    return Checkout.fromJson(doc.data()!, doc.id);
  }
}
