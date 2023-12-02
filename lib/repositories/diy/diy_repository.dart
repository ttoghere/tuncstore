import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuncstore/models/diy_model.dart';
import 'package:tuncstore/models/models.dart';
import 'package:tuncstore/repositories/diy/base_diy_repository.dart';

class DIYRepository extends BaseDIYRepository {
  final FirebaseFirestore _firebaseFirestore;

  DIYRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<DIYModel>> getDIYitems() {
    return _firebaseFirestore
        .collection('diyCollection')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => DIYModel.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<Product?> getProductById(String productId) async {
    try {
      final DocumentSnapshot snapshot =
          await _firebaseFirestore.collection('products').doc(productId).get();

      if (snapshot.exists) {
        return Product.fromSnapshot(snapshot);
      } else {
        return null;
      }
    } catch (error) {
      log('Ürün çekme hatası: $error');
      return null;
    }
  }
}
