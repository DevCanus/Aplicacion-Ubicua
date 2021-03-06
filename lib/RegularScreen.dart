import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:proyecto/LoginAccount.dart';
import './LoginAccount.dart';
import './GameScreen.dart';

class regularScreen extends StatefulWidget {
  const regularScreen({Key key}) : super(key: key);

  @override
  _regularScreenState createState() => _regularScreenState();
}

class _regularScreenState extends State<regularScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        elevation: 20.0,
      ),

      body: Container(
        child:Padding(
          padding: EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 0.0),
          child: CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 0.45,
              scrollDirection: Axis.vertical,
            ),
            items: <Widget>[
              GestureDetector(
                onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => gameScreen()),); },
                child: buildColors(context),
              ),
              buildShapes(context),
              buildSizes(context),
              buildMix(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildColors(BuildContext context) => Padding(
    padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.02,
        top: 0.0,
        right: MediaQuery.of(context).size.width * 0.02,
        bottom: 0.0
    ),

    child:Card(
      color: Colors.lightGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child:Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02,
                    top: 0.0,
                    right: MediaQuery.of(context).size.width * 0.02,
                    bottom: 0.0),
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child:Image(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/colors.jpg'),
                  ),
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                  child: Text(
                    'Colores',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  Widget buildShapes(BuildContext context) => Padding(
    padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.02,
        top: 0.0,
        right: MediaQuery.of(context).size.width * 0.02,
        bottom: 0.0
    ),

    child:Card(
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child:Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02,
                    top: 0.0,
                    right: MediaQuery.of(context).size.width * 0.02,
                    bottom: 0.0),
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child:Image(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/colors.jpg'),
                  ),
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                  child: Text(
                    'Formas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  Widget buildSizes(BuildContext context) => Padding(
    padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.02,
        top: 0.0,
        right: MediaQuery.of(context).size.width * 0.02,
        bottom: 0.0
    ),

    child:Card(
      color: Colors.orange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child:Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02,
                    top: 0.0,
                    right: MediaQuery.of(context).size.width * 0.02,
                    bottom: 0.0),
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child:Image(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/colors.jpg'),
                  ),
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                  child: Text(
                    'Tama??os',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  Widget buildMix(BuildContext context) => Padding(
    padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.02,
        top: 0.0,
        right: MediaQuery.of(context).size.width * 0.02,
        bottom: 0.0
    ),

    child:Card(
      color: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child:Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02,
                    top: 0.0,
                    right: MediaQuery.of(context).size.width * 0.02,
                    bottom: 0.0),
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child:Image(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/colors.jpg'),
                  ),
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                  child: Text(
                    'Mix',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}