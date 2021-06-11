import 'package:firebase_auth/firebase_auth.dart';

Future<dynamic> signIn(String email, String password) async
{
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return FirebaseAuth.instance.currentUser;
  }
  catch (e) {
    print(e);
    return null;
  }
}

Future<dynamic> register(String email, String password) async
{
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return FirebaseAuth.instance.currentUser;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use')
      print('Ya existe una cuenta para el email proporcionado');

    return null;
  } catch (e) {
      print(e.toString());
      return null;
  }
}