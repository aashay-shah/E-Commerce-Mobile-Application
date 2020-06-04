import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryList extends StatelessWidget {
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
          "Categories",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("Categories").snapshots(),
        builder: (context, snapshot){
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              DocumentSnapshot category = snapshot.data.documents[index];
              return ListTile(
                title: Text(category["category"]),
              );
            },
          );
        },
      ),
    );
  }
}
