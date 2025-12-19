import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew_app/models/brew.dart';
import 'package:brew_crew_app/screens/home/brew_tile.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class BrewList extends StatefulWidget {
  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
