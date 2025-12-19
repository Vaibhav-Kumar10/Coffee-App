import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew_app/wrapper.dart';
import 'package:brew_crew_app/models/user.dart';
import 'package:brew_crew_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize any services or configurations here if needed
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // 👈 REMOVE DEBUG BANNER
        title: 'Brew Crew',
        home: Wrapper(),
      ),
    );
  }
}
