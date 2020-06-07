import 'package:flutter/material.dart';
import 'package:flutterfireauth/ui/final_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  double total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          "Shopping Cart",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('Cart').snapshots(),
          // ignore: missing_return
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Scaffold(
                body: Center(
                  child: Text("Your Cart is Empty", style: TextStyle(color: Colors.grey),),
                )
              );

            } else {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  // ignore: missing_return
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot products = snapshot.data.documents[index];
                    // total = total + products['price'];
                    String prod_id = products['id'];
                    return Padding(
                      padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                      child: Container(
//                        decoration: BoxDecoration(
//                          border:
//                              Border(bottom: BorderSide(color: Colors.pink)),
//                        ),
                        child: ListTile(
                          leading: Container(
                            height: 250,
                            child: Image.network(
                              products['images'],
                              height: 200,
                              width: 100,
                            ),
                          ),
                          title: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(products['name']),
                              ),
                              Expanded(
                                  child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.pink,
                                ),
                                onPressed: () async {
                                  Firestore.instance
                                      .collection('Cart')
                                      .document(prod_id)
                                      .delete();
                                },
                              ))
                            ],
                          ),
                          subtitle: Text(
                            "Rs " + products['price'].toString(),
                            style: TextStyle(color: Colors.pink),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: new Text("Total Amount"),
                // subtitle: new Text(total.toString()),
              ),
            ),
            Expanded(
              child: new MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new FinalPage()));
                  Firestore.instance
                      .collection('Cart')
                      .getDocuments()
                      .then((snapshot) {
                    for (DocumentSnapshot ds in snapshot.documents) {
                      ds.reference.delete();
                    }
                  });
                },
                child: new Text("Check Out",
                    style: TextStyle(color: Colors.white)),
                color: Colors.pink,
              ),
            )
          ],
        ),
      ),
    );
  }
}
