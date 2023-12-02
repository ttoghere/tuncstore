import 'package:tuncstore/models/diy_model.dart';
import 'package:tuncstore/models/models.dart';

abstract class BaseDIYRepository {
  Stream<List<DIYModel>> getDIYitems();
  Future<Product?> getProductById(String productId);
}
