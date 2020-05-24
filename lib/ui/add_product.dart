import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfireauth/db/brand.dart';
import 'package:flutterfireauth/db/category.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  List<DocumentSnapshot> Brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> Categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;

  @override
  void initState() {
    // TODO: implement initState
    _getCategories();
    //_getBrands();
  }

  List<DropdownMenuItem<String>> getCategoriesDropdown(){
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < Categories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(Categories[i].data['category']),
                value: Categories[i].data['category']));
      });
    }
    return items;
  }

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
        child: Column(
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
              child: Text("Enter Product Details: ", style: TextStyle(color: Colors.pink, fontSize: 14.0),),
            ),
            Padding(
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
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Category: ", style: TextStyle(color: Colors.pink, fontSize: 16.0),),
                ),
                DropdownButton(
                  items: categoriesDropDown,
                  onChanged: changeSelectedCategory,
                  value: _currentCategory,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  _getCategories() async{
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print(data);
    setState(() {
      Categories = data;
      categoriesDropDown = getCategoriesDropdown();
      _currentCategory = Categories[0].data['category'];
    });
  }

  changeSelectedCategory(String selectedCategory){
    setState(() => _currentCategory = selectedCategory);
  }
}
