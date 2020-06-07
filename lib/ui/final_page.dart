import 'package:flutter/material.dart';
import 'package:flutterfireauth/ui/home.dart';


class FinalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Happy",
                style: TextStyle(
                  fontSize: 80.0,
                  fontFamily: "Pacifico",
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Shopping",
                style: TextStyle(
                  fontSize: 80.0,
                  fontFamily: "Pacifico",
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Material(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.pink,
            elevation: 0.0,
            child: FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new HomePage()));
              },
              child: Text(
                "Shop More",
                style: TextStyle(color: Colors.white, fontSize: 17.0),
              ),
            ),
          ),
        ));
  }
}
