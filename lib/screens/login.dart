import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qikk2do/services/auth.dart';
import 'package:sign_button/create_button.dart';
import 'package:sign_button/sign_button.dart';

class Login extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Login({
    Key key,
    @required this.auth,
    @required this.firestore,
  }) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Builder(builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: "Username"),
                  controller: _emailController,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: "Password"),
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () async {
                    final String retVal = await Auth(auth: widget.auth).signIn(
                        email: _emailController.text,
                        password: _passwordController.text);
                    if (retVal == "Success") {
                      _emailController.clear();
                      _passwordController.clear();
                    } else {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text(retVal)));
                    }
                  },
                  child: const Text("Sign In"),
                ),
                SignInButton(
                  onPressed: () async {
                    final UserCredential retVal =
                        await Auth(auth: widget.auth).signInWithGoogle();
                    // if (retVal.user. == "Success") {
                    //   _emailController.clear();
                    //   _passwordController.clear();
                    // } else {
                    //   Scaffold.of(context)
                    //       .showSnackBar(SnackBar(content: Text()));
                    // }
                  },
                  buttonType: ButtonType.googleDark,
                  btnText: "Sign In with Google",
                ),
                SignInButton(
                    buttonType: ButtonType.apple,
                    onPressed: () {
                      log("clicked");
                    }),
                FlatButton(
                    onPressed: () async {
                      final String retVal = await Auth(auth: widget.auth)
                          .createAccount(
                              email: _emailController.text,
                              password: _passwordController.text);
                      if (retVal == "Success") {
                        _emailController.clear();
                        _passwordController.clear();
                      } else {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text(retVal)));
                      }
                    },
                    child: const Text("Create Account")),
                FlatButton(
                    onPressed: () async {
                      final String retVal = await Auth(auth: widget.auth)
                          .signIn(
                              email: _emailController.text,
                              password: _passwordController.text);
                      if (retVal == "Success") {
                        _emailController.clear();
                        _passwordController.clear();
                      } else {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text(retVal)));
                      }
                    },
                    child: const Text("Forgotten Password")),
              ],
            );
          }),
        ),
      ),
    );
  }
}
