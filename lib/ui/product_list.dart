import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.pink,
        leading: Icon(
          Icons.close,
          color: Colors.white,
        ),
        title: Text(
          "Products",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("Products").snapshots(),
        builder: (context, snapshot){
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              DocumentSnapshot product = snapshot.data.documents[index];
              return ListTile(
                leading: Image.network(product["images"]),
                title: Text(product["productName"]),
                //subtitle: (product["price"]),
              );
            },
          );
        },
      ),
    );
  }
}
