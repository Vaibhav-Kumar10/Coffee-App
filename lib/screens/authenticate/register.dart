import 'package:flutter/material.dart';
import 'package:brew_crew_app/shared/loading.dart';
import 'package:brew_crew_app/shared/constants.dart';
import 'package:brew_crew_app/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "", password = "", error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("Sign Up to Brew Crew"),
              centerTitle: true,
              actions: [
                TextButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Sign In", style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    widget.toggleView();
                    // print("Register - toggleView");
                  },
                ),
              ],
            ),

            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),

              // Register Form
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    TextFormField(
                      // For validating email input
                      validator: (value) =>
                          value!.isEmpty ? "Enter an email" : null,

                      decoration: textInputDecoration.copyWith(
                        hintText: "Email",
                      ),

                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),

                    SizedBox(height: 20.0),
                    TextFormField(
                      // For validating password input
                      validator: (value) => value!.isEmpty
                          ? "Enter a password"
                          : value.length < 6
                          ? "Password must be at least 6 characters"
                          : null,

                      decoration: textInputDecoration.copyWith(
                        hintText: "Password",
                      ),

                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      obscureText: true,
                    ),

                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                      ),
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        // Form is valid only if all validators return null
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          // print("Email - ${email}.");
                          // print("Password - ${password}.");
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            // print("Error registering user !!!!");
                            setState(() {
                              error =
                                  "Error registering user !!!! \n The email address is badly formatted.  !!!!";
                              loading = false;
                            });
                          } else {
                            // This automatically redirects to Home as the auth state changes
                            // print("Sign In Succesfull.");
                            // print("$result");
                            // print("${result.uid}");
                          }
                        }
                      },
                    ),
                    // Show error
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
