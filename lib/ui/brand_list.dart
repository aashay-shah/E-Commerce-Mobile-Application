import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BrandList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.pink,
        title: Text(
          "Brands",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("Brands").snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot brand = snapshot.data.documents[index];
                return ListTile(
                  title: Text(brand["brand"]),
                );
              },
            );
          }
          else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
