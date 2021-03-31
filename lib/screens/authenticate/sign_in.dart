import 'package:farm_2_table/services/auth.dart';
import 'package:farm_2_table/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:farm_2_table/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({ this.toggleView });
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // input field state
  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Sign In ~ F2T',
          style: TextStyle(
              color: Colors.black,
              fontSize: 22.0
          ),
        ),
        actions: <Widget>[
          // FlatButton.icon(
          //     icon: Icon(Icons.person),
          //     label: Text('Register'),
          //     onPressed: () {
          //       widget.toggleView();
          //     }
          // )
        ],
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: double.infinity,
                              minHeight:  280.0
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              )
                            ),
                          ),
                        ),
                        Container(
                          height: 100.0,
                          child: Image.asset(
                            'assets/images/F2T_logo.png',
                            fit: BoxFit.fitHeight,
                          ),
                        )
                    ],
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide( //                   <--- left side
                                  color: Colors.lightGreen,
                                  width: 5.0,
                                ),
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black
                              ),
                            ),
                          ),
                        ),
                        Container(
                            child:  FlatButton.icon(
                                icon: Icon(Icons.person),
                                label: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black
                                  ),
                                ),
                                onPressed: () {
                                  widget.toggleView();
                                }
                            )
                        ),
                      ],
                    ),
                  )
                ]
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter an email': null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (val) => val.length < 6 ? 'Enter password at least 6+ characters long': null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    ),
                    SizedBox(height: 30.0),
                    RaisedButton(
                        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 60.0),
                        color: Colors.lightGreen,
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                            setState(() {
                              loading = true;
                            });
                            dynamic result = _auth.loginWithEmailAndPassword(email, password);
                            if(result == null){
                              setState(() {
                                error = 'please supply valid credentials';
                                loading = true;
                              });
                            }
                          }
                        }
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
