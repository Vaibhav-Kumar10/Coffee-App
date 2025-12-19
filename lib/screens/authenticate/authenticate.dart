import 'package:flutter/material.dart';
import 'package:brew_crew_app/screens/authenticate/register.dart';
import 'package:brew_crew_app/screens/authenticate/sign_in.dart';
import 'package:brew_crew_app/shared/loading.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true, loading = false;

  // void toggleView() {
  //   setState(() {
  //     loading = true;
  //     showSignIn = !showSignIn;
  //     loading = false;
  //   });
  // }
  void toggleView() async {
    setState(() => loading = true);

    await Future.delayed(Duration(milliseconds: 300));

    setState(() {
      showSignIn = !showSignIn;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : showSignIn
        ? SignIn(toggleView: toggleView)
        : Register(toggleView: toggleView);
  }
}
