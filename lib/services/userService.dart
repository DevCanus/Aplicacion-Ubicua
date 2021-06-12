import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  ///Obtiene los datos del usuario que ha iniciado sesión
  Future<User> getDataUsuario() async {
    User usuario;
    usuario = _auth.currentUser;
    return usuario;
  }

  ///Agrega la cita al usuario
  Future<bool> agregarCita(String nombrePaciente, String fecha, String tipo, User usuario) async {
    bool resultado = false;

    var cita = db.collection('users').doc(usuario.uid).collection('citas').doc();
    await db.collection('users').doc(usuario.uid).collection('citas').doc(cita.id).set({
      'paciente': nombrePaciente,
      'fecha': fecha,
      'tipo': tipo,
    }).then((value) => {
      resultado = true,
    });

    return resultado;
  }

  ///Edita una cita seleccionada
  Future<bool> editarCita(String nombrePaciente, String fecha, String tipo, User usuario, String idCita) async {
    bool resultado = false;

    await db.collection('users').doc(usuario.uid).collection('citas').doc(idCita).update({
      'paciente': nombrePaciente,
      'fecha': fecha,
      'tipo': tipo,
    }).then((value) => {
      resultado = true,
    });

    return resultado;
  }

  ///Obtiene las citas del usuario en la fecha seleccionada del calendario
  Stream<QuerySnapshot> obtenerCitasUsuario(String fecha, User usuario) {
    return db
        .collection('users')
        .doc(usuario.uid)
        .collection('citas')
        .where('fecha', isGreaterThanOrEqualTo: fecha)
        .where('fecha', isLessThanOrEqualTo: fecha)
        .snapshots();
  }

  ///Elimina la cita seleccionada
  Future<bool> eliminarCita(String idCita) async {
    bool result = false;
    User usuario;
    usuario = await getDataUsuario();

    await db.collection('users').doc(usuario.uid).collection('citas').doc(idCita).delete().then((value) => {
      result = true,
    });

    return result;
  }

  ///Desloguea al usuario de la aplicación
  Future logOut() async {
    _auth.signOut();
  }

  ///Verifica si la sesión esta iniciada
  Future<bool> verificaSesion() async {
    try {
      var usuario = _auth.currentUser;
      return (usuario.uid != null) ? true : false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
