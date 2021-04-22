import 'package:farm_2_table/models/user.dart';
import 'package:farm_2_table/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user obj based on FireBaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }
  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      FirebaseUser user = (await _auth.signInAnonymously()).user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  // sign in email/password
  Future loginWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e){
      print(e.toString());
      return null;
    }
  }
  // register in email/password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      // create a new document for user with uid
      await DatabaseService(uid: user.uid).updateUserProduceData('Beans', 2000.00, 'image_ril', '45kg');
      return _userFromFirebaseUser(user);
    } catch (e){
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
      print('signing out');
    }catch(e){
      print(e);
      return null;
    }
  }
}