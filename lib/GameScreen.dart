import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:proyecto/utils/data.dart';
import 'package:proyecto/utils/tileModel.dart';
import './LoginAccount.dart';
import './RegularScreen.dart';
import './HelpScreen.dart';
import './themes/color.dart';

class gameScreen extends StatefulWidget {
  const gameScreen({Key key}) : super(key: key);
  @override
  _gameScreenState createState() => _gameScreenState();
}

class _gameScreenState extends State<gameScreen> {
  List<TileModel> tiles = new List<TileModel>();
  List<TileModel> halfs = new List<TileModel>();
  int counter;
  int answer;
  Random random;
  bool changeorientation = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    counter = 0;
    tiles = getTiles();
    halfs = getHalfs();
    random = new Random();
    answer = random.nextInt(tiles.length);
  }

@override
  dispose(){
    if(changeorientation)
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20.0,
        actions: [
          IconButton(
              icon: Icon(Icons.help_outline,color: Colors.white),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => helpScreen()),);
                },
          ),
        ],
      ),
      body: Container(
        color: secondary,
        height: MediaQuery.of(context).size.height - AppBar().preferredSize.height,
        child: buildGame(context),
      ),
    );
  }
  
  @override
  Widget buildGame(BuildContext context) => Padding(
    padding: EdgeInsets.all(5.0),
    child: GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 4/3,
      children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              color: Colors.white,
              elevation: 10.0,
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: Image.asset(halfs[answer].imageAssetPath),
              ),
            ),
          ),
          Center(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: List.generate(tiles.length, (index) {
                return Tile(
                  imageAssetPath: tiles[index].getImage(),
                  selected: tiles[index].isSelected(),
                  answer: answer,
                  index: index,
                  parent: this,
                );
              }
            ),
          ),
        ),
      ],
    ),
  );
}


class Tile extends StatefulWidget {
  String imageAssetPath;
  int answer;
  int index;
  bool selected;

  _gameScreenState parent;

  Tile({this.imageAssetPath, this.answer, this.index, this.selected, this.parent});

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.selected = true;
          if(widget.answer == widget.index) {
            setState(() {
              widget.parent.changeorientation = false;
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => gameScreen()));
            });
          }
        });
      },
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: Card(
          color: Colors.white,
          elevation: 10.0,
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: widget.selected ? ((widget.answer == widget.index) ? Image.asset('assets/images/right.jpg') : Image.asset("assets/images/wrong.jpg")) : Image.asset(widget.imageAssetPath),
          ),
        ),
      ),
    );
  }
}
