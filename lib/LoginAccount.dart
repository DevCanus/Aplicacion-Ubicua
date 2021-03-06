import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './RegularScreen.dart';
import './CalendarScreen.dart';
import './CreateAccount.dart';
import './themes/color.dart';
import './utils/userAuth.dart';

Future<void> main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyect',
      theme: MyTheme.defaultTheme,
      home: MyHomePage(title: 'Bienvenido!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final email = TextEditingController();
  final pass = TextEditingController();

  @override

  void dispose() {
    // Clean up the controller when the widget is disposed.
    email.dispose();
    pass.dispose();

    super.dispose();
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
              padding: EdgeInsets.only(left: 40.0, top: 20.0, right: 40.0, bottom: 20.0),
              children: <Widget>[
                Container(
                  height: 140.0,
                  padding: EdgeInsets.all(20.0),
                  child: Image(
                    image: AssetImage('assets/images/user.png'),
                  ),
                ),

                Container(
                  height: 70.0,
                  child:Column(
                    children: <Widget>[
                      Text(
                        'Iniciar Sesi??n',
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(thickness: 1.0,),

                Container(
                  height: 70.0,
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
                  height: 100.0,
                  child: TextField(
                    controller: pass,
                    cursorColor: secondaryDark,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Contrase??a',
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
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: secondaryDark,
                    ),
                    child: Text(
                      'Continuar'
                    ),
                    onPressed: () async {
                      var user = await signIn(email.text, pass.text);

                      if(user != null)
                      {
                        var document = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
                        Map<String, dynamic> data = document.data();
                        var value = data['rol'];

                        if("Terapeuta".compareTo(value) == 0)
                          Navigator.push(context, MaterialPageRoute(builder: (context) => calendarScreen()),);
                        else
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => regularScreen()),);
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
                  height: 40.0,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              'Si no tienes una cuenta: '
                          ),

                          InkWell(
                            child: Text(
                              'Registrate!',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: secondaryDark,
                              ),
                            ),
                            onTap: () {  Navigator.push(context, MaterialPageRoute(builder: (context) => createAccount()),); }
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
