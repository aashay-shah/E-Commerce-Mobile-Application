import 'package:flutter/material.dart';
import 'package:flutterfireauth/utils/firebase_auth.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';

// My Own Imports
import 'package:flutterfireauth/components/horizontal_listview.dart';
import 'package:flutterfireauth/components/products.dart';
import 'package:flutterfireauth/ui/checkout.dart';
import 'package:flutterfireauth/ui/admin.dart';
import 'package:flutterfireauth/ui/favorites.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String userEmail = "";

  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 175.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/c1.jpg'),
          AssetImage('images/m1.jpeg'),
          AssetImage('images/m2.jpg'),
          AssetImage('images/w1.jpeg'),
          AssetImage('images/w3.jpeg'),
          AssetImage('images/w4.jpeg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        dotColor: Colors.pink,
        dotBgColor: Colors.transparent,
        indicatorBgPadding: 2.0,
        showIndicator: true,
        noRadiusForIndicator: true,
      ),
    );
    return Scaffold(
        key: _key,
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text('Shopping App'),
          actions: <Widget>[
            new IconButton(
                icon: Icon(Icons.star, color: Colors.white),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Favorites()));
                }),
            new IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Checkout()));
                })
          ],
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
//            header
              new UserAccountsDrawerHeader(
                //accountName: Text('Aashay Shah'),
                accountEmail: Text(userEmail),
                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ),
                decoration: new BoxDecoration(
                  color: Colors.pink,
                ),
              ),
//            body
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new HomePage()));
                },
                child: ListTile(
                    title: Text('Home Page'),
                    leading: Icon(
                      Icons.home,
                      color: Colors.pink,
                    )),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('My Account'),
                    leading: Icon(
                      Icons.person,
                      color: Colors.pink,
                    )),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('My Orders'),
                    leading: Icon(
                      Icons.shopping_basket,
                      color: Colors.pink,
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Checkout()));
                },
                child: ListTile(
                    title: Text('Shopping Cart'),
                    leading: Icon(
                      Icons.shopping_cart,
                      color: Colors.pink,
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Favorites()));
                },
                child: ListTile(
                    title: Text('Favorites'),
                    leading: Icon(
                      Icons.favorite,
                      color: Colors.pink,
                    )),
              ),
              Divider(),
              InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('Settings'),
                    leading: Icon(
                      Icons.settings,
                    )),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('About'),
                    leading: Icon(
                      Icons.help,
                    )),
              ),
              InkWell(
                onTap: () {
                  AuthProvider().logOut();
                },
                child: ListTile(
                    title: Text('Log Out'),
                    leading: Icon(
                      Icons.exit_to_app,
                    )),
              ),
              InkWell(
                  onDoubleTap: () async {
                    bool res = await AuthProvider().getCurrentUserEmail();
                    if (!res) {
                      _key.currentState.showSnackBar(SnackBar(
                          content: Text("You don't have permission!")));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => new Admin()));
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("version 1.0"),
                      )
                    ],
                  )
//                ListTile(
//                  title: Text('Admin'),
//                  leading: Icon(
//                    Icons.person_pin
//                  ),
//                ),
                  ),
            ],
          ),
        ),
        body: new Column(
          children: <Widget>[
            //image carousel
            image_carousel,
            // padding
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: new Text('Categories',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ),

            HorizontalList(),
            // padding
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: new Text('Recent Products',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ),

            Flexible(
              child: Products(),
            ),
          ],
        ));
  }

  getUserInfo() async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    setState(() {
      userEmail = user.email;
    });
    print(userEmail);
  }
}

/*class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Home page"),
            RaisedButton(
              child: Text("Log out"),
              onPressed: (){
                AuthProvider().logOut();
              },
            )
          ],
        ),
      ),
    );
  }
}*/
