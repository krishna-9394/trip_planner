import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  User? user;

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        user = (await _auth.signInWithCredential(authCredential)).user;
        return true;
      }
    } on FirebaseAuthException catch (error) {
      print(error);
      rethrow;
    }
    return false;
  }

  Future<User?> getUserDetails() async {
    return user;
  }

  void signOut() {
    _googleSignIn.signOut();
    _auth.signOut();
  }
}
