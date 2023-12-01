import 'package:tuncstore/models/diy_model.dart';

abstract class BaseDIYRepository {
  Stream<List<DIYModel>> getDIYitems();
}
