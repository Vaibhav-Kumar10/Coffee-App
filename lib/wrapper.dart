import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew_app/models/user.dart';
import 'package:brew_crew_app/screens/home/home.dart';
import 'package:brew_crew_app/screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // null - if signed out
    // user - if signed in
    final user = Provider.of<AppUser?>(context);
    // print("Wrapper user: $user");

    // return either Home or Authenticate widget
    return user == null ? Authenticate() : Home();
  }
}
