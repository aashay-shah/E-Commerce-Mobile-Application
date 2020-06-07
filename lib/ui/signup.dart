import 'package:flutter/material.dart';
import 'package:flutterfireauth/ui/login.dart';
import 'package:flutterfireauth/main.dart';
import 'package:flutterfireauth/utils/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  //TextEditingController _confirmPasswordController;
  final FocusNode emailField = FocusNode();
  final FocusNode passwordField = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String gender;
  String groupValue = "male";
  bool hidePass = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "");
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    //_confirmPasswordController = TextEditingController(text: "");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Stack(
        children: <Widget>[
          Image.asset('images/register.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Image.asset(
                  'images/lg.png',
                  width: 220.0,
                  height: 160.0,
                ),
              )),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 210.0),
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
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: "Enter Full Name",
                            icon: Icon(Icons.person_add),
                          ),
                          onEditingComplete: (){
                            FocusScope.of(context).requestFocus(emailField);
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "Male",
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Radio(
                                value: "male",
                                activeColor: Colors.redAccent,
                                focusColor: Colors.white,
                                hoverColor: Colors.white,
                                groupValue: groupValue,
                                onChanged: (e) => valueChanged(e)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "Female",
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Radio(
                                value: "female",
                                activeColor: Colors.redAccent,
                                focusColor: Colors.white,
                                hoverColor: Colors.white,
                                groupValue: groupValue,
                                onChanged: (e) => valueChanged(e)),
                          ),
                        ),
                      ],
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
                        child: TextFormField(
                          focusNode: emailField,
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
                          child: TextFormField(
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
                  /*Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.5),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextField(
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                icon: Icon(Icons.verified_user),
                              ),
                            ),
                          ),
                        ),
                      ),*/
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.lightBlueAccent,
                      elevation: 0.0,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          "Register",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        onPressed: () async{
                          if (_emailController.text.isEmpty ||
                              _passwordController.text.isEmpty) {
                            _key.currentState
                                .showSnackBar(SnackBar(content: Text("Email and Password cannot be Empty")));
                            return;
                          }
                          bool res = await AuthProvider().signUpWithEmail(_emailController.text, _passwordController.text);
                          print(res);
                          if (!res) {
                            _key.currentState
                                .showSnackBar(SnackBar(content: Text("User Registration Failed")));
                          }else{
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => new MainScreen()));
                          }
                        },
                          /*if (_emailController.text.isEmpty ||
                                  _passwordController.text.isEmpty) {
                                print("Email and Password cannot be empty");
                                return;
                              }
                              bool res = await AuthProvider().signInWithEmail(
                                  _emailController.text, _passwordController.text);
                              print(res);
                              if (!res) {
                                print("Login failed");
                              }*/

                      ),
                    ),
                  ),
                  /*Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Forgot Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),*/
                  /*Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){},
                          child: Text("Don't have an Account? Sign Up!", style: TextStyle(color: Colors.red), textAlign: TextAlign.center,),
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
                      ),*/
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: new Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.redAccent,
                      elevation: 0.0,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new LoginPage()));
                        },
                        /*async {
                              bool res = await AuthProvider().loginWithGoogle();
                              if (!res) print("Error logging in with google");
                            },*/
                        child: Text(
                          "Already Have an Account? Login",
                          style: TextStyle(color: Colors.white, fontSize: 17.0),
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
    );
  }
  valueChanged(e) {
    setState(() {
      if (e == "male") {
        groupValue = e;
        gender = e;
      } else if (e == "female") {
        groupValue = e;
        gender = e;
      }
    });
  }
}
