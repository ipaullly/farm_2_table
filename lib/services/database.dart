import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_2_table/models/produce.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });
  var uuid = Uuid();
  // collection reference
  final CollectionReference produceCollection = Firestore.instance.collection('products');
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference orderCollection = Firestore.instance.collection('orders');

  // *******
  // Produce Collection
  // *******
  Future<void> addProduce(
    String produceName,
    double price,
    int minUnit,
    String unitMeasure
  ) {
    return produceCollection.document(uuid.v4()).setData({
      'produceName': produceName,
      'price': price,
      'minUnit': minUnit,
      'unitMeasure': unitMeasure
    });
  }
  Future updateUserProduceData(String name, double price, String imageUrl, String minUnit) async {
    var docId = '';
    return await produceCollection.document(docId).setData({
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'minUnit': minUnit,
      'vendorId': uid,
    });
  }
  // *******
  // *******
  // users Collection
  // *******
  Future<void> addUser(String name, String role) async {
    return await userCollection
        .document(uid)
        .setData({
          'name': name,
          'role': role,
          'uid': uid
        });
  }
  // orders Collection
  // *******
  Future<void> addOrder(String name, String role) async {
    return await userCollection
        .document(uid)
        .setData({
      'name': name,
      'role': role,
      'uid': uid
    });
  }

  //produce list from snapshot
  List<Produce> _produceListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return Produce(
        produceName: doc.data['produceName'] ?? '',
        price: doc.data['price'] ?? 0,
        imageUrl: doc.data['imageUrl'] ?? '',
        minUnit: doc.data['minUnit'] ?? '',
        unitMeasure: doc.data['unitMeasure'] ?? ''
      );
    }).toList() ;
  }
  // get produce stream
  Stream<List<Produce>> get produce {
    return produceCollection
      .snapshots()
      .map(_produceListFromSnapshot);
  }
}