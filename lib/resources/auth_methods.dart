import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practicebloom/models/user.dart' as model;

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async{
    User currentUser = _auth.currentUser!;
    
    DocumentSnapshot documentSnapshot = await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  //user signup
  Future<String> signUpUser({
    required String fullname,
    required String email,
    required String password,
  }) async{
    String res = "Some error occurred";
    try{
      if(email.isNotEmpty || fullname.isNotEmpty || password.isNotEmpty){
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        
        //add user to database

        model.User user = model.User(
          fullname: fullname,
          email: email,
          uid: cred.user!.uid,
          practiceEntries: [],
          goalList: [],
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
        res = "success";
      } else{
        res = 'Please fill out all of the fields.';
      }
    } catch(error){
      res = error.toString();
    }
    return res;
  }

  //user login
  Future<String> loginUser({
    required String email,
    required String password,
  }) async{
    String res = 'Some error occurred';

    try{
      if(email.isNotEmpty || password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
      } else{
        res = 'Please fill out all of the fields.';
      }
    } catch(error){
      res = error.toString();
    }
    return res;
  }
}
