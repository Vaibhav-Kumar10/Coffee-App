import 'package:flutter/material.dart';
import 'package:brew_crew_app/models/user.dart';
import 'package:brew_crew_app/shared/loading.dart';
import 'package:brew_crew_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew_app/services/database.dart';

class SettingsForm extends StatefulWidget {
  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  String? _curName, _curSugars;
  int? _curStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data!;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Update your Brew Settings",
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20.0),

                // Update Name
                TextFormField(
                  initialValue: _curName ?? userData.name,
                  validator: (val) =>
                      val!.isEmpty ? "Please enter a name" : null,
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  onChanged: (val) {
                    setState(() {
                      _curName = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),

                // Drop down to update sugars
                DropdownButtonFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: "Enter sugars",
                  ),
                  initialValue: _curSugars ?? userData.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text("$sugar Sugars"),
                    );
                  }).toList(),
                  onChanged: (val) {
                    // print(val);
                    setState(() {
                      _curSugars = val;
                    });
                  },
                ),

                SizedBox(height: 20.0),
                // Slider
                Slider(
                  label: (_curStrength ?? 100).toString(),
                  min: 100,
                  max: 900,
                  divisions: 8,
                  value: (_curStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_curStrength ?? userData.strength],
                  inactiveColor:
                      Colors.brown[_curStrength ?? userData.strength],
                  onChanged: (val) =>
                      setState(() => _curStrength = val.round()),
                ),

                SizedBox(height: 20.0),

                // Update Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                  ),
                  child: Text("Update", style: TextStyle(color: Colors.black)),
                  onPressed: () async {
                    // print(_curName);
                    // print(_curSugars);
                    // print(_curStrength);
                    // Form is valid only if all validators return null
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _curSugars ?? userData.sugars,
                        _curName ?? userData.name,
                        _curStrength ?? userData.strength,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
