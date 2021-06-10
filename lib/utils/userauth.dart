import 'package:firebase_auth/firebase_auth.dart';

Future<bool> logIn(String email, String password) async {

}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if(e.code == 'weak-password')
      print('La contraseña proporcionada es muy debil.');
    else if (e.code == 'email-already-in-use')
      print('Ya existe una cuenta para el email proporcionado');

    return false;
  } catch (e) {
      print(e.toString());
      return false;
    }
}