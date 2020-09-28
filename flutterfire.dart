import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> checkAuth() async {
  await Firebase.initializeApp();

  FirebaseAuth auth = FirebaseAuth.instance;
  if (auth.currentUser != null) {
    print("Already Signed in");
  } else {
    print("Signed Out");
  }
}

Future<void> signUp() async {
  await Firebase.initializeApp();

  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "bleyldev@gmail.com", password: "123456");
    print("Success");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e.toString());
  }
}

Future<void> signIn() async {
  await Firebase.initializeApp();

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "bleyldev@gmail.com", password: "123456");
    print("Success");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    } else {
      print(e.code.toString());
    }
  }
}

Future<void> signOut() async {
  await Firebase.initializeApp();

  try {
    await FirebaseAuth.instance.signOut();
    print("Success");
  } catch (e) {
    print(e.toString());
  }
}

Future<void> resetPassword() async {
  await Firebase.initializeApp();

  await FirebaseAuth.instance
      .sendPasswordResetEmail(email: "bleyldev@gmail.com");
}

Future<void> verifyEmail() async {
  await Firebase.initializeApp();

  User user = FirebaseAuth.instance.currentUser;
  user.sendEmailVerification();
}

Future<void> setDisplayName() async {
  await Firebase.initializeApp();

  User user = FirebaseAuth.instance.currentUser;
  user.updateProfile(displayName: "bleylDev");
}

Future<void> checkDisplayName() async {
  await Firebase.initializeApp();

  User user = FirebaseAuth.instance.currentUser;
  print(user.displayName);
}
