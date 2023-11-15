import 'package:hive/hive.dart';
import 'package:tuncstore/models/product_model/product_model.dart';
import 'package:tuncstore/repositories/local_storage/base_local_storage.dart';

class LocalStorage extends BaseLocalStotage {
  String boxName = "wishlist_products";
  @override
  Future<void> addProductToWishlist(Box box, Product product) async {
    await box.put(product.id, product);
  }

  @override
  Future<void> clearWishlist(Box box) async {
    await box.clear();
  }

  @override
  List<Product> getWishlist(Box box) {
    return box.values.toList() as List<Product>;
  }

  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<Product>(boxName);
    return box;
  }

  @override
  Future<void> removeProductFromWishlist(Box box, Product product) async {
    await box.delete(product.id);
  }
}
