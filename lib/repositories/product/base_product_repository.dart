import 'package:tuncstore/models/models.dart';

abstract class BaseProductRepository {
  Stream<List<Product>> getAllProducts();
}
