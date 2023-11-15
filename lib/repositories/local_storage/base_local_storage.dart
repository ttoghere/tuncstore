import 'package:hive/hive.dart';
import 'package:tuncstore/models/product_model/product_model.dart';

abstract class BaseLocalStotage {
  Future<Box> openBox();
  List<Product> getWishlist(Box box);
  Future<void> addProductToWishlist(Box box, Product product);
  Future<void> removeProductFromWishlist(Box box, Product product);
  Future<void> clearWishlist(Box box);
}
