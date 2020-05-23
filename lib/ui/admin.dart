import 'package:flutter/material.dart';
import 'package:flutterfireauth/db/category.dart';
import 'package:flutterfireauth/db/brand.dart';
import 'package:flutterfireauth/ui/add_product.dart';

enum Page { dashboard, manage }

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  Page _selectedPage = Page.dashboard;
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  BrandService _brandService = BrandService();
  CategoryService _categoryService = CategoryService();

  //MaterialColor active = Colors.white;
  //MaterialColor notActive = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      setState(() => _selectedPage = Page.dashboard);
                    },
                    icon: Icon(
                      Icons.dashboard,
                      color: _selectedPage == Page.dashboard
                          ? Colors.white
                          : Colors.grey,
                    ),
                    label: Text('Dashboard'))),
            Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      setState(() => _selectedPage = Page.manage);
                    },
                    icon: Icon(
                      Icons.sort,
                      color: _selectedPage == Page.manage
                          ? Colors.white
                          : Colors.grey,
                    ),
                    label: Text('Manage'))),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.pink,
      ),
      body: _loadScreen(),
    );
  }

  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
            ListTile(
              subtitle: FlatButton.icon(
                onPressed: null,
                icon: Icon(
                  Icons.attach_money,
                  size: 30.0,
                  color: Colors.green,
                ),
                label: Text('12,000',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0, color: Colors.green)),
              ),
              title: Text(
                'Revenue',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, color: Colors.black),
              ),
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(
                                Icons.people_outline,
                                color: Colors.pink,
                              ),
                              label: Text(
                                "Users",
                                style: TextStyle(color: Colors.black),
                              )),
                          subtitle: Text(
                            '7',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.pink, fontSize: 60.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(
                                Icons.category,
                                color: Colors.pink,
                              ),
                              label: Text(
                                "Categories",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12.0),
                              )),
                          subtitle: Text(
                            '23',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.pink, fontSize: 60.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(
                                Icons.track_changes,
                                color: Colors.pink,
                              ),
                              label: Text(
                                "Products",
                                style: TextStyle(color: Colors.black),
                              )),
                          subtitle: Text(
                            '120',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.pink, fontSize: 60.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(
                                Icons.tag_faces,
                                color: Colors.pink,
                              ),
                              label: Text(
                                "Sold",
                                style: TextStyle(color: Colors.black),
                              )),
                          subtitle: Text(
                            '13',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.pink, fontSize: 60.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Colors.pink,
                              ),
                              label: Text(
                                "Orders",
                                style: TextStyle(color: Colors.black),
                              )),
                          subtitle: Text(
                            '5',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.pink, fontSize: 60.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(
                                Icons.close,
                                color: Colors.pink,
                              ),
                              label: Text(
                                "Return",
                                style: TextStyle(color: Colors.black),
                              )),
                          subtitle: Text(
                            '0',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.pink, fontSize: 60.0),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.add,
                color: Colors.pink,
              ),
              title: Text(
                "Add Product",
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => new AddProduct()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.change_history,
                color: Colors.pink,
              ),
              title: Text(
                "Products List",
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.add_circle,
                color: Colors.pink,
              ),
              title: Text(
                "Add Category",
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                _categoryAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.category,
                color: Colors.pink,
              ),
              title: Text(
                "Category List",
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.add_circle_outline,
                color: Colors.pink,
              ),
              title: Text(
                "Add Brand",
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                _brandAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.library_books,
                color: Colors.pink,
              ),
              title: Text(
                "Brand List",
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {},
            ),
            Divider(),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  void _categoryAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: categoryController,
          validator: (value) {
            if (value.isEmpty) {
              return 'Category Cannot Be Empty';
            }
          },
          decoration: InputDecoration(hintText: 'Add Category'),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if(categoryController.text != Null){
                _categoryService.createCategory(categoryController.text);
              }
              _key.currentState.showSnackBar(SnackBar(content: Text("Category Added")));
              Navigator.pop(context);
            },
            child: Text('Add', style: TextStyle(color: Colors.pink),)),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel', style: TextStyle(color: Colors.pink),)),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }
  void _brandAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: brandController,
          validator: (value) {
            if (value.isEmpty) {
              return 'Brand Cannot Be Empty';
            }
          },
          decoration: InputDecoration(hintText: 'Add Brand'),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if(brandController.text != Null){
                _brandService.createBrand(brandController.text);
              }
              _key.currentState.showSnackBar(SnackBar(content: Text("Brand Added")));
              Navigator.pop(context);
            },
            child: Text('Add', style: TextStyle(color: Colors.pink),)),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel', style: TextStyle(color: Colors.pink),)),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }
}
