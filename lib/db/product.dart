import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class ProductService{
  Firestore _firestore = Firestore.instance;
  String ref = 'Products';
  void uploadProduct({String productName, String category, String brand, int quantity, double price, List sizes, List images}){
    var id = Uuid();
    String productId = id.v1();
    _firestore.collection(ref).document(productId).setData({
      'id': productId,
      'name': productName,
      'category': category,
      'brand': brand,
      'quantity': quantity,
      'price': price,
    });
  }
}