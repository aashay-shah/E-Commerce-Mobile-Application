import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfireauth/ui/product_details.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Your Favorites", style: TextStyle(color: Colors.white),)
      ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('Favorite').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    itemCount: snapshot.data.documents.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot products =
                      snapshot.data.documents[index];
                      return Single_prod(
                          prod_name: products['name'],
                          prod_picture: products['images'],
                          prod_quantity: products['quantity'],
                          prod_price: products['price'],
                          prod_brand: products['brand'],
                          prod_category: products['category'],
                          prod_id: products['id']
                      );
                    });
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_quantity;
  final prod_price;
  final prod_brand;
  final prod_category;
  final prod_id;

  Single_prod({
    this.prod_name,
    this.prod_picture,
    this.prod_quantity,
    this.prod_price,
    this.prod_brand,
    this.prod_category,
    this.prod_id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(
              onTap: () =>
                  Navigator.of(context).push(new MaterialPageRoute(
                    // passing the values of the product to the product details page
                      builder: (context) =>
                      new ProductDetails(
                          product_detail_name: prod_name,
                          product_detail_new_price: prod_price,
                          product_detail_quantity: prod_quantity,
                          product_detail_picture: prod_picture,
                          product_detail_brand: prod_brand,
                          product_detail_category: prod_category,
                          product_detail_id: prod_id
                      ))),
              child: GridTile(
                header: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.pink,
                    ),
                    onPressed: () async {
                      Firestore.instance
                          .collection('Favorite')
                          .document(prod_id)
                          .delete();
                    },
                  ),
                ),
                  footer: Container(
                      color: Colors.white70,
                      child: ListTile(
                        leading: Text(
                          prod_name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        title: Text(
                          "Rs $prod_price",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                      )),
                  child: Image.network(
                    prod_picture,
                    //fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
