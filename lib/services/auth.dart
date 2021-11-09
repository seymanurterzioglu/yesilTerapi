import "package:firebase_auth/firebase_auth.dart";
import 'package:fitterapi/modules/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  theUser? _userFromFirebase(User? user){
    if (user != null) {
      return theUser(uid:user.uid);
    } else {
      return null;
    }
  }

  //auth change user stream
  Stream<theUser?> get user {
    return _auth.authStateChanges()
        .map((User? user) => _userFromFirebase(user!));
        // .map(_userFromFirebase); same as up line
  }



  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password

  //register with email & password

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }


}
