import 'package:tuncstore/models/models.dart';

abstract class BaseProductRepository {
  Stream<List<Product>> getAllProducts();
  Future<Product?> getProductById(String productId);
}
