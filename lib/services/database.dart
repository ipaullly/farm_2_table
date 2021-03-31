import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_2_table/models/produce.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });
  // collection reference
  final CollectionReference produceCollection = Firestore.instance.collection('products');

  Future updateUserProduceData(String name, String price, String imageUrl, String minUnit) async {
    return await produceCollection.document(uid).setData({
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'minUnit': minUnit
    });
  }

  //produce list from snapshot
  List<Produce>_produceListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return Produce(
        name: doc.data['name'] ?? '',
        price: doc.data['price'] ?? '',
        imageUrl: doc.data['imageUrl'] ?? '',
        minUnit: doc.data['minUnit'] ?? ''
      );
    }).toList() ;
  }
  // get produce stream
  Stream<List<Produce>> get produce {
    return produceCollection.snapshots()
      .map(_produceListFromSnapshot);
  }
}