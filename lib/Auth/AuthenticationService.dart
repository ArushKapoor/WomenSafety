import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AuthenticationService {
  User user;
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);
  Stream<User> get authCredentialChanges => _firebaseAuth.idTokenChanges();
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  FirebaseAuth emailVerification() {
    return _firebaseAuth;
  }

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          //Navigator.of(context).pop();

          UserCredential result = await _auth.signInWithCredential(credential);

          user = result.user;

          //   if(user != null){
          //Navigator.push(context, MaterialPageRoute(
          //   //     builder: (context) => HomeScreen(user: user,)
          //   //   ));
          //   // }else{
          //   //   print("Error");
          //   // }

          //   //This callback would gets called when verification is done auto maticlly
          // },
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          // showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   builder: (context) {
          //     return AlertDialog(
          //       title: Text("Give the code?"),
          //       content: Column(
          //         mainAxisSize: MainAxisSize.min,
          //         children: <Widget>[
          //           TextField(
          //             controller: _codeController,
          //           ),
          //         ],
          //       ),
          //       actions: <Widget>[
          //         FlatButton(
          //           child: Text("Confirm"),
          //           textColor: Colors.white,
          //           color: Colors.blue,
          //           onPressed: () async{
          //             final code = _codeController.text.trim();
          //             AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);

          //             AuthResult result = await _auth.signInWithCredential(credential);

          //             FirebaseUser user = result.user;

          //             if(user != null){
          //               Navigator.push(context, MaterialPageRoute(
          //                   builder: (context) => HomeScreen(user: user,)
          //               ));
          //             }else{
          //               print("Error");
          //             }
          //           },
          //         )
          //       ],
          //     );
          //   }
          // );
        },
        codeAutoRetrievalTimeout: (String verificationid) {});
  }

  Future<String> signUp({String email, String password}) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (!_firebaseAuth.currentUser.emailVerified) {
        await _firebaseAuth.currentUser.sendEmailVerification();
      }
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return "Signed Up";
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return "Signed In";
  }
}
