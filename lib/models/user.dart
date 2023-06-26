
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String fullname;
  final String email;
  final String uid;
  final List practiceEntries;
  final List goalList;

  const User({
    required this.fullname,
    required this.email,
    required this.uid,
    required this.practiceEntries,
    required this.goalList
  });

  Map<String, dynamic> toJson() =>{
    "fullname": fullname,
    "email": email,
    "uid": uid,
    "practiceEntries": practiceEntries,
    "goalList": goalList,
  };

  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      fullname: snapshot["fullname"],
      email: snapshot["email"],
      uid: snapshot["uid"],
      practiceEntries: snapshot["practiceEntries"],
      goalList: snapshot["goalList"],
    );
  }
}