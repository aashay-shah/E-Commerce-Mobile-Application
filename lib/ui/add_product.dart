import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfireauth/db/brand.dart';
import 'package:image_picker/image_picker.dart';
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
  TextEditingController quatityController = TextEditingController();
  List<DocumentSnapshot> Brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> Categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;
  List<String> selectedSizes = <String>[];
  File _image1;
  File _image2;
  File _image3;


  @override
  void initState() {
    // TODO: implement initState
    _getCategories();
    _getBrands();
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

  List<DropdownMenuItem<String>> getBrandsDropdown(){
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < Brands.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(Brands[i].data['brand']),
                value: Brands[i].data['brand']));
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        onPressed: (){
                          _selectImage(ImagePicker.pickImage(source: ImageSource.gallery), 1);
                        },
                        borderSide: BorderSide(color: Colors.pink.withOpacity(0.5), width: 3.0),
                        child: _displayChild1()
                        /*Padding(
                          padding: const EdgeInsets.fromLTRB(14.0, 30.0, 14.0, 30.0),
                          child: Icon(Icons.add, color: Colors.pink,),
                        ),*/
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        onPressed: (){
                          _selectImage(ImagePicker.pickImage(source: ImageSource.gallery), 2);
                        },
                        borderSide: BorderSide(color: Colors.pink.withOpacity(0.5), width: 3.0),
                        child: _displayChild2()
                        /*Padding(
                          padding: const EdgeInsets.fromLTRB(14.0, 30.0, 14.0, 30.0),
                          child: Icon(Icons.add, color: Colors.pink,),
                        ),*/
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        onPressed: (){
                          _selectImage(ImagePicker.pickImage(source: ImageSource.gallery), 3);
                        },
                        borderSide: BorderSide(color: Colors.pink.withOpacity(0.5), width: 3.0),
                        child: _displayChild3()
                        /*Padding(
                          padding: const EdgeInsets.fromLTRB(14.0, 30.0, 14.0, 30.0),
                          child: Icon(Icons.add, color: Colors.pink,),
                        ),*/
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
                padding: const EdgeInsets.all(4.0),
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
                    child: Text("Category: ", style: TextStyle(color: Colors.pink, fontSize: 12.0),),
                  ),
                  DropdownButton(
                    items: categoriesDropDown,
                    onChanged: changeSelectedCategory,
                    value: _currentCategory,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Brand: ", style: TextStyle(color: Colors.pink, fontSize: 12.0),),
                  ),
                  DropdownButton(
                    items: brandsDropDown,
                    onChanged: changeSelectedBrand,
                    value: _currentBrand,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: quatityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Quantity',
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Quantity Cannot Be Empty';
                    }
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Available Sizes', style: TextStyle(color: Colors.pink, fontSize: 16.0),),
              ),

              Row(
                children: <Widget>[
                  Checkbox(value: selectedSizes.contains('XS'), onChanged: (value) => changeSelectedSize('XS')),
                  Text('XS'),

                  Checkbox(value: selectedSizes.contains('S'), onChanged: (value) => changeSelectedSize('S')),
                  Text('S'),

                  Checkbox(value: selectedSizes.contains('M'), onChanged: (value) => changeSelectedSize('M')),
                  Text('M'),

                  Checkbox(value: selectedSizes.contains('L'), onChanged: (value) => changeSelectedSize('L')),
                  Text('L'),

                  Checkbox(value: selectedSizes.contains('XL'), onChanged: (value) => changeSelectedSize('XL')),
                  Text('XL'),
                ],
              ),

              Row(
                children: <Widget>[
                  Checkbox(value: selectedSizes.contains('28'), onChanged: (value) => changeSelectedSize('28')),
                  Text('28'),

                  Checkbox(value: selectedSizes.contains('30'), onChanged: (value) => changeSelectedSize('30')),
                  Text('30'),

                  Checkbox(value: selectedSizes.contains('32'), onChanged: (value) => changeSelectedSize('32')),
                  Text('32'),

                  Checkbox(value: selectedSizes.contains('34'), onChanged: (value) => changeSelectedSize('34')),
                  Text('34'),

                  Checkbox(value: selectedSizes.contains('36'), onChanged: (value) => changeSelectedSize('36')),
                  Text('36'),
                ],
              ),

              Row(
                children: <Widget>[
                  Checkbox(value: selectedSizes.contains('40'), onChanged: (value) => changeSelectedSize('38')),
                  Text('38'),

                  Checkbox(value: selectedSizes.contains('42'), onChanged: (value) => changeSelectedSize('40')),
                  Text('40'),

                  Checkbox(value: selectedSizes.contains('44'), onChanged: (value) => changeSelectedSize('42')),
                  Text('42'),

                  Checkbox(value: selectedSizes.contains('46'), onChanged: (value) => changeSelectedSize('44')),
                  Text('44'),

                  Checkbox(value: selectedSizes.contains('48'), onChanged: (value) => changeSelectedSize('46')),
                  Text('46'),
                ],
              ),

              RaisedButton(
                color: Colors.pink,
                textColor: Colors.white,
                child: Text('Add Product'),
                onPressed: (){},
              )
            ],
          ),
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

  _getBrands() async{
    List<DocumentSnapshot> data = await _brandService.getBrands();
    print(data);
    setState(() {
      Brands = data;
      brandsDropDown = getBrandsDropdown();
      _currentBrand = Brands[0].data['brand'];
    });
  }

  changeSelectedCategory(String selectedCategory){
    setState(() => _currentCategory = selectedCategory);
  }

  changeSelectedBrand(String selectedBrand){
    setState(() => _currentBrand = selectedBrand);
  }

  changeSelectedSize(String size) {
    if(selectedSizes.contains(size)){
      setState(() {
        selectedSizes.remove(size);
      });
    }else{
      setState(() {
        selectedSizes.insert(0, size);
      });
    }
  }

  _selectImage(Future<File> pickImage, int imageNumber) async{
    File tempImg = await pickImage;
    switch(imageNumber){
      case 1:  setState(() => _image1 = tempImg);
      break;
      case 2:  setState(() => _image2 = tempImg);
      break;
      case 3:  setState(() => _image3 = tempImg);
      break;
    }
  }

  Widget _displayChild1() {
    if(_image1 == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(Icons.add, color: Colors.pink,),
      );
    }else{
      return Image.file(_image1, fit: BoxFit.fill, width: double.infinity,);
    }
  }

  Widget _displayChild2() {
    if(_image2 == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(Icons.add, color: Colors.pink,),
      );
    }else{
      return Image.file(_image2, fit: BoxFit.fill, width: double.infinity,);
    }
  }

  Widget _displayChild3() {
    if(_image3 == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(Icons.add, color: Colors.pink,),
      );
    }else{
      return Image.file(_image3, fit: BoxFit.fill, width: double.infinity,);
    }
  }

  
}
