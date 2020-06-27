import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final _auth = FirebaseAuth.instance;
  final googleSignIn = new GoogleSignIn();
  FirebaseUser user;
  final databaseReference = Firestore.instance;


  Future<bool> signInWithGoogle() async {
    try {
      GoogleSignInAccount googleAccount;

      googleAccount = await googleSignIn.signIn();
      if (googleAccount == null) {
        return false;
      } else {
        final GoogleSignInAuthentication googleauth =
            await googleAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.getCredential(
            idToken: googleauth.idToken, accessToken: googleauth.accessToken);

        AuthResult result = await _auth.signInWithCredential(credential);
        if (result.user == null) {
          return false;
        } else {
          user = result.user;
          print('user ${user.uid}');
          print(googleSignIn.currentUser.displayName);
          return true;
        }
      }
    } catch (e) {
      print('error logging in with google');
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      final displayname =await  _auth.currentUser().then((value) => value.displayName);
      print('$displayname Signed out');
      await googleSignIn.signOut();
      await _auth.signOut();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> autoLogin() async {
    if ( await _auth.currentUser() != null) {
      // print(googleSignIn.currentUser.displayName);
      _auth.currentUser().then((value) => print(value.displayName));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkuserInfo() async{
    
      final uid = await FirebaseAuth.instance.currentUser().then((value) => value.uid);
      final result = await databaseReference
          .collection('Haryana/1/Palwal/Users/userid')
          .document(uid)
          .get()
          .then((doc) 
          {

              if (doc.exists) {

                return true;
            } else {

                return false;
            }
  
          });
          if(result)
          {
            return true;
          }
          else
          {
            return false;
          }
          // return false;
  }

  // Future<bool> updateUserInfo() async {
  //   final uid = await FirebaseAuth.instance.currentUser().then((value) => value.uid);
  //     final result = await databaseReference
  //         .collection('Haryana/1/Palwal/Users/userid')
  //         .document(uid).setData(data)
  //         .get()
  //         .then((doc) 
  //         {

  //             if (doc.exists) {

  //               return true;
  //           } else {

  //               return false;
  //           }
  
  //         });
  //         if(result)
  //         {
  //           return true;
  //         }
  //         else
  //         {
  //           return false;
  //         }
  // }

}
          
