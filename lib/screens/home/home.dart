import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew_app/services/auth.dart';
import 'package:brew_crew_app/services/database.dart';
import 'package:brew_crew_app/screens/home/settings_form.dart';
import 'package:brew_crew_app/screens/home/brew_list.dart';
import 'package:brew_crew_app/models/brew.dart';
import 'package:brew_crew_app/shared/loading.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        /*
        1️⃣ isScrollControlled: true
        - Allows the bottom sheet to take full height
        - Enables it to resize when keyboard opens
         */
        isScrollControlled: true,
        builder: (context) {
          return Container(
            // padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            /*
            2️⃣ MediaQuery.viewInsets.bottom
            - This gives the keyboard height
            - Adds bottom padding equal to keyboard height
            - Pushes content above the keyboard
            */
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            // child: SettingsForm(),
            /*
            3️⃣ SingleChildScrollView
            - Allows scrolling when:
            - keyboard is open
            - content height > available space
            */
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.85,
                ),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: SettingsForm(),
              ),
            ),
          );
        },
      );
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: [],
      child: loading
          ? Loading()
          : Scaffold(
              backgroundColor: Colors.brown[50],
              appBar: AppBar(
                title: Text("Brew Crew Home"),
                centerTitle: true,
                backgroundColor: Colors.brown[400],
                elevation: 0.0,
                actions: <Widget>[
                  TextButton.icon(
                    icon: Icon(Icons.person, color: Colors.white),
                    label: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      setState(() => loading = true);
                      await _auth.signOut();
                      setState(() => loading = false);
                    },
                  ),

                  /*
                  IconButton(
                    onPressed: () async {
                      setState(() => loading = true);
                      await Future.delayed(Duration(seconds: 1));
                      setState(() => loading = false);
                    },
                    icon: Icon(Icons.settings),
                  ),

                  ElevatedButton.icon(
                    onPressed: () async {
                      setState(() => loading = true);
                      await Future.delayed(Duration(seconds: 1));
                      setState(() => loading = false);
                    },
                    icon: Icon(Icons.settings),
                    label: Text("Settings"),
                  ),
*/
                  TextButton.icon(
                    onPressed: () async {
                      // print('Settings showed');
                      _showSettingsPanel();
                    },
                    icon: Icon(Icons.settings),
                    label: Text("Settings"),
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                  ),
                ],
              ),
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/coffee_bgp.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BrewList(),
              ),

              /*
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Card(
                      elevation: 5.0,
                      color: Colors.red[50],
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.thermostat),
                              ),
                              Text(
                                "Hot Coffee",
                                style: TextStyle(
                                  color: Colors.red[100],
                                  fontSize: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Card(
                      elevation: 5.0,
                      color: Colors.lightBlue[50],
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.cloud_circle),
                              ),
                              Text(
                                "Cold Coffee",
                                style: TextStyle(
                                  color: Colors.lightBlueAccent[100],
                                  fontSize: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              */
              /*
              bottomNavigationBar: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                    onPressed: () async {
                      setState(() => loading = true);
                      await Future.delayed(Duration(seconds: 1));
                      setState(() => loading = false);
                    },
                    icon: Icon(Icons.home),
                    label: Text("Home"),

                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[500],
                      iconSize: 24.0,
                    ),
                  ),

                  IconButton(
                    onPressed: () async {
                      setState(() => loading = true);
                      await Future.delayed(Duration(seconds: 1));
                      setState(() => loading = false);
                    },
                    icon: Icon(Icons.home),

                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[500],
                      iconSize: 24.0,
                    ),
                  ),

                  IconButton(
                    onPressed: () async {
                      setState(() => loading = true);
                      await Future.delayed(Duration(seconds: 1));
                      setState(() => loading = false);
                    },
                    icon: Icon(Icons.settings),

                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[500],
                      iconSize: 24.0,
                    ),
                  ),

                  TextButton.icon(
                    onPressed: () async {
                      setState(() => loading = true);
                      await Future.delayed(Duration(seconds: 1));
                      setState(() => loading = false);
                    },
                    icon: Icon(Icons.settings),
                    label: Text("Settings"),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[500],
                      iconSize: 24.0,
                    ),
                  ),
                ],
              ),
              */
            ),
    );
  }
}
