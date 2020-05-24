import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryService{
  Firestore _firestore = Firestore.instance;
  String ref = 'Categories';
  void createCategory(String name){
    var id = Uuid();
    String categoryId = id.v1();
    _firestore.collection(ref).document(categoryId).setData({'category': name});
  }
  Future<List<DocumentSnapshot>> getCategories() => _firestore.collection(ref).getDocuments().then((snaps){
    print(snaps.documents.length);
    return snaps.documents;
  });
}