import 'package:flutter/material.dart';
import 'package:flutterfireauth/ui/product_details.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      'name': 'Blazer',
      'picture': 'images/products/blazer1.jpeg',
      'old_price': 120,
      'price': 99,
    },
    {
      'name': 'Dress',
      'picture': 'images/products/dress1.jpeg',
      'old_price': 100,
      'price': 60,
    },
    {
      'name': 'Heels',
      'picture': 'images/products/hills1.jpeg',
      'old_price': 40,
      'price': 25,
    },
    {
      'name': 'Skirt',
      'picture': 'images/products/skt1.jpeg',
      'old_price': 60,
      'price': 40,
    },
    {
      'name': 'Pants',
      'picture': 'images/products/pants1.jpg',
      'old_price': 100,
      'price': 75,
    },
    {
      'name': 'Shoes',
      'picture': 'images/products/shoe1.jpg',
      'old_price': 50,
      'price': 19,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Single_prod(
              prod_name: product_list[index]['name'],
              prod_picture: product_list[index]['picture'],
              prod_old_price: product_list[index]['old_price'],
              prod_price: product_list[index]['price'],
            ),
          );
        });
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Single_prod({
    this.prod_name,
    this.prod_picture,
    this.prod_old_price,
    this.prod_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                // passing the values of the product to the product details page
                  builder: (context) => new ProductDetails(
                    product_detail_name: prod_name,
                    product_detail_picture: prod_picture,
                    product_detail_new_price: prod_price,
                    product_detail_old_price: prod_old_price,
                  ))),
              child: GridTile(
                  footer: Container(
                      color: Colors.white70,
                      child: new Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                                prod_name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16.0),
                              )),
                          Expanded(
                              child: Text(
                                "\$${prod_price}",
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              )),
                        ],
                      )),
                  child: Image.asset(
                    prod_picture,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
