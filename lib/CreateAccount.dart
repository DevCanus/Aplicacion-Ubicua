import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/calendarScreen.dart';
import 'package:proyecto/utils/userAuth.dart';
import './loginAccount.dart';
import './regularScreen.dart';
import './themes/color.dart';
import './utils/userAuth.dart';

class createAccount extends StatefulWidget {
  const createAccount({Key key}) : super(key: key);

  @override
  _createAccountState createState() => _createAccountState();
}

class _createAccountState extends State<createAccount> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final ver = TextEditingController();
  String role = 'Padre/hijo';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    email.dispose();
    pass.dispose();
    ver.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20.0,
      ),

      body: Center(
        child: SizedBox(
          width: 500.0,
          child: Card(
            elevation: 10.0,
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                  left: 40.0, top: 20.0, right: 40.0, bottom: 20.0),
              children: <Widget>[
                Container(
                  height: 140.0,
                  padding: EdgeInsets.all(20.0),
                  child: Image(
                    image: AssetImage('assets/images/user.png'),
                  ),
                ),

                Container(
                  height: 60.0,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Crear Cuenta',
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(thickness: 1.0,),

                Container(
                  height: 60.0,
                  child: TextField(
                    controller: email,
                    cursorColor: secondaryDark,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: secondaryDark,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 60.0,
                  child: TextField(
                    controller: pass,
                    cursorColor: secondaryDark,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Contraseña',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: secondaryDark,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 60.0,
                  child: TextField(
                    controller: ver,
                    cursorColor: secondaryDark,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Verificar contraseña',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: secondaryDark,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 60.0,
                  child: DropdownButton<String>(
                    value: role,
                    items: <String>['Padre/hijo', 'Terapeuta'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        role = newValue;
                      });
                    },
                  )
                ),

                Container(
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: secondaryDark,
                    ),
                    child: Text(
                        'Continuar'
                    ),
                    onPressed: () async {
                      if (pass.text.compareTo(ver.text) == 0) {
                        var user = await register(email.text, pass.text);
                        if (user != null) {
                          FirebaseFirestore.instance.collection('users').doc(user.uid).set(
                          {
                            "rol": role,
                          }).then((_) {
                            print("Success!");
                          });

                          if(role.compareTo("Terapeuta") == 0)
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => calendarScreen()),);
                          else
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => regularScreen()),);
                        }
                      }
                    },
                  ),
                ),

                Container(
                  height: 20.0,
                ),

                Divider(thickness: 1.0,),

                Container(
                  height: 10.0,
                ),

                Container(
                  height: 30.0,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              '¿Ya tienes una cuenta? '
                          ),

                          InkWell(
                              child: Text(
                                'Inicia Sesión!',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: secondaryDark,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => MyApp()),);
                              }
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}