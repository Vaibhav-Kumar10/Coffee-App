import 'package:flutter/material.dart';
import 'package:brew_crew_app/shared/loading.dart';
import 'package:brew_crew_app/shared/constants.dart';
import 'package:brew_crew_app/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
              title: Text("Sign In to Brew Crew"),
              centerTitle: true,
              actions: [
                TextButton.icon(
                  icon: Icon(Icons.person),
                  label: Text(
                    "Register",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    widget.toggleView();
                    // print("Signin - toggleView");
                  },
                ),
              ],
            ),

            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              /*
              // Email Sign in Form
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
                          ? "Enter password"
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
                        "Sign In",
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
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            // print("Error siging in !!!!");
                            setState(() {
                              error =
                                  "Error siging in !!!! \nCOULD NOT SIGN IN WITH THOSE CREDENTIALS !!";
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
*/
              // /*
              // Anonymous Sign In Button
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });

                  dynamic result = await _auth.signInAnony();

                  if (result == null) {
                    print("Error signing in !!!!");

                    setState(() {
                      error =
                          "Error siging in !!!! \nCOULD NOT SIGN IN WITH THOSE CREDENTIALS !!";
                      loading = false;
                    });
                  } else {
                    print("Sign In Succesfull.");
                    print("$result");
                    print("${result.uid}");
                  }
                },
                child: Text('Sign In Anonymously'),
              ),
              // */
            ),
          );
  }
}
