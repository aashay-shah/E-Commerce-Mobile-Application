import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfireauth/utils/firebase_auth.dart';
import 'package:flutterfireauth/ui/signup.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final FocusNode passwordField = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Stack(
        children: <Widget>[
          Image.asset('images/back.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
          Container(
            color: Colors.black.withOpacity(0.6),
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 140.0),
                child: Image.asset(
                  'images/lg.png',
                  width: 240.0,
                  height: 180.0,
                ),
              )),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 260.0),
            child: Center(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white.withOpacity(0.5),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Enter Email",
                            icon: Icon(Icons.alternate_email),
                          ),
                          onEditingComplete: (){
                            FocusScope.of(context).requestFocus(passwordField);
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.5),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextField(
                            focusNode: passwordField,
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Enter Password",
                              icon: Icon(Icons.lock),
                            ),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.lightBlueAccent,
                      elevation: 0.0,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        onPressed: () async {
                          if (_emailController.text.isEmpty ||
                              _passwordController.text.isEmpty) {
                            _key.currentState
                                .showSnackBar(SnackBar(content: Text("Email and Password cannot be Empty")));
                            return;
                          }
                          bool res = await AuthProvider().signInWithEmail(
                              _emailController.text, _passwordController.text);
                          print(res);
                          if (!res) {
                            _key.currentState
                                .showSnackBar(SnackBar(content: Text("Login Failed. Check your Login Credentials")));
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Forgot Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new SignUp()));
                      },
                      child: Text(
                        "Don't have an Account? Sign Up!",
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    /*RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0),
                              children: [
                                TextSpan(
                                    text:
                                        "Don't have an Account? Click here to"),
                                TextSpan(
                                    text: " Sign Up!",
                                    style: TextStyle(color: Colors.red))
                              ]
                          )
                      )*/
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: new Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.redAccent,
                      elevation: 0.0,
                      child: FlatButton(
                        onPressed: () async {
                          bool res = await AuthProvider().loginWithGoogle();
                          if (!res) _key.currentState
                              .showSnackBar(SnackBar(content: Text("Google Authentication Failed. Try Again")));
                        },
                        child: Text(
                          "Sign In with Google",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
        ],
      ),
      /*bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
          child: FlatButton(
              color: Colors.redAccent,
              onPressed: () async {
                bool res = await AuthProvider().loginWithGoogle();
                if (!res) print("Error logging in with google");
              },
              child: Text(
                "Sign in / Sign up with google",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),*/
    );

    /*(body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 100.0),
              Text("Login", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),),
              const SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Login with Google"),
                onPressed: () async {
                  bool res = await AuthProvider().loginWithGoogle();
                  if(!res)
                    print("error logging in with google");
                },
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: "Enter email"
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Enter password"
                ),
              ),
              const SizedBox(height: 10.0),
              RaisedButton(
                child: Text("Login"),
                onPressed: () async {
                  if(_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                    print("Email and password cannot be empty");
                    return;
                  }
                  bool res = await AuthProvider().signInWithEmail(_emailController.text, _passwordController.text);
                  print(res);
                  if(!res) {
                    print("Login failed");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );*/
  }
}
