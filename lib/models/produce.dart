import 'package:cloud_firestore/cloud_firestore.dart';

class Produce {
  final String id;
  final String produceName;
  final double price;
  final String imageUrl;
  final int minUnit;
  final String unitMeasure;
  final String vendorId;

  Produce({
    this.id,
    this.produceName,
    this.price,
    this.imageUrl,
    this.unitMeasure,
    this.minUnit,
    this.vendorId
  });

  factory Produce.fromFirebase(DocumentSnapshot doc) {
    Map data = doc.data;

    return Produce(
      id: doc.documentID,
      produceName: data['produceName'] ?? '',
      price: data['price'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      minUnit: data['minUnit'] ?? '',
      vendorId: data['vendorId'] ?? ''
    );
  }
}