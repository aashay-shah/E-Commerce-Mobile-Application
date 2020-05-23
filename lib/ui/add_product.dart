import 'package:flutter/material.dart';
import 'dart:convert';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.pink,
        leading: Icon(Icons.close, color: Colors.white,),
        title: Text("Add Product", style: TextStyle(color: Colors.white),),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      onPressed: (){},
                      borderSide: BorderSide(color: Colors.pink.withOpacity(0.5), width: 3.0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14.0, 30.0, 14.0, 30.0),
                        child: Icon(Icons.add, color: Colors.pink,),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      onPressed: (){},
                      borderSide: BorderSide(color: Colors.pink.withOpacity(0.5), width: 3.0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14.0, 30.0, 14.0, 30.0),
                        child: Icon(Icons.add, color: Colors.pink,),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      onPressed: (){},
                      borderSide: BorderSide(color: Colors.pink.withOpacity(0.5), width: 3.0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14.0, 30.0, 14.0, 30.0),
                        child: Icon(Icons.add, color: Colors.pink,),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Enter Product Name: ", style: TextStyle(color: Colors.pink, fontSize: 14.0),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.redAccent.withOpacity(0.2),
                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: productNameController,
                    decoration: InputDecoration(
                      hintText: "Product Name",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Product Name Cannot Be Empty';
                      }
                      else if (value.length > 10){
                        return 'Product Name cannot have more than 10 Characters';
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
