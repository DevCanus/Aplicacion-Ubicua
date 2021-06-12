import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:proyecto/utils/data.dart';
import 'package:proyecto/utils/tileModel.dart';
import './loginAccount.dart';
import './regularScreen.dart';
import './themes/color.dart';

class gameScreen extends StatefulWidget {
  const gameScreen({Key key}) : super(key: key);
  @override
  _gameScreenState createState() => _gameScreenState();
}

class _gameScreenState extends State<gameScreen> {
  List<TileModel> tiles = new List<TileModel>();
  List<TileModel> halfs = new List<TileModel>();
  bool rebuild;
  int answer;
  Random random = new Random();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    tiles = getTiles();
    halfs = getHalfs();
    answer = random.nextInt(tiles.length - 1);
  }

  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20.0,
        actions: [
          IconButton(
              icon: Icon(Icons.help_outline,color: Colors.white70),
              onPressed: null,
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