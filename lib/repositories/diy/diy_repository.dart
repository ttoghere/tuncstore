import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuncstore/models/diy_model.dart';
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
}
