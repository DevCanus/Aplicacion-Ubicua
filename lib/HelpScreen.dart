import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/LoginAccount.dart';
import './themes/color.dart';


class helpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Column (
      ),),
      body: Container(
        color: secondary,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 10.0,
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
                    child: Column(
                      children: <Widget>[
                        _TextoTitulo("¡Bienvenido a la ayuda!"),
                        _TextoNormal("Para jugar se mostrará en la parte izquierda de la pantalla una imagen incompleta y de las opciones en la parte derecha tendrás que elegir la que sea la imagen completa."),
                        _image(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }
  Widget _TextoTitulo(String text){
    return Container(
      padding: const EdgeInsets.only(left: 15.0,top: 20.0, right: 15.0, bottom: 0.0),
      child: SizedBox(
        width: 300.0,
        child: Text(text, style: TextStyle( fontSize: 25.0, color: secondaryDark,), textAlign: TextAlign.center,),
      )
    );
  }
  Widget _TextoNormal(String text){
    return Container(
      padding: const EdgeInsets.only(left: 15.0,top: 20.0, right: 15.0, bottom: 0.0),
      child: SizedBox(
        width: 550.0,
        child: Text(text, style: TextStyle( fontSize: 20.0, ), textAlign: TextAlign.justify, ),
      )
    );
  }
  Widget _image(){
    return Container(
      child: Image(
        image: AssetImage('assets/images/example.jpg'),
        width: 550.0,
        height: 250.0,
      ),
    );
  }

}