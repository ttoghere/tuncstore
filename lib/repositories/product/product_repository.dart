import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuncstore/models/product_model/product_model.dart';
import 'package:tuncstore/repositories/product/base_product_repository.dart';

class ProductRepository extends BaseProductRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProductRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<Product?> getProductById(String productId) async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();

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
