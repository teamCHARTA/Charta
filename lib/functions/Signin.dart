import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
bool newuser=false;
bool rollcheck=false;
class GoogleSigninProvider extends ChangeNotifier{
  final googleSignin = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogin() async {
    final googleUser = await googleSignin.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final authresult = await FirebaseAuth.instance.signInWithCredential(
        credential);
    final user = authresult.user;




      if (authresult.additionalUserInfo!.isNewUser) {
            if (user != null) {
              newuser = true;
              rollcheck=true;
            } else {
              newuser = false;
            }
          }else {
            newuser = false;
          }

        Newusercheck();
    notifyListeners();

  }
Future logout()async{
    await googleSignin.disconnect();
    FirebaseAuth.instance.signOut();
}
}

 bool Newusercheck() {

  return newuser;
}

void Newrollupdate(int x) {
  if(x==1){rollcheck=false;}else{rollcheck=true;}
}
bool Newrollcheck(){
  return rollcheck;
}