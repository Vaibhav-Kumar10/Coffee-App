import 'package:brew_crew_app/models/brew.dart';
import 'package:brew_crew_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // create a collection reference
  final CollectionReference brewCollections = FirebaseFirestore.instance
      .collection('brews');

  // used 2 times - 1. When user is created at 'Sign Up'. 2. When user goes to settings.
  Future updateUserData(String sugars, String name, int strength) async {
    // if uid is new and collection does not exists, Firestore creates a new document and link to uid.
    return await brewCollections.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Brew(
        sugars: data['sugars'] ?? "0",
        name: data['name'] ?? "",
        strength: data['strength'] ?? 0,
      );
    }).toList();
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserData(
      uid: uid ?? "",
      name: data['name'],
      sugars: data['sugars'],
      strength: data['strength'],
    );
  }

  // Get brews stream
  Stream<List<Brew>> get brews {
    // return a stream of list of brew objects
    return brewCollections.snapshots().map(_brewListFromSnapshot);
  }

  // Stream to return user data document snapshot
  Stream<UserData> get userData {
    return brewCollections.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
