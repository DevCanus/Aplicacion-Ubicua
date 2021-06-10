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
  String answer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    tiles = getTiles();
    answer = tiles[Random().nextInt(tiles.length - 1)].imageAssetPath;
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
              icon: Icon(Icons.help_outline),
              onPressed: null,
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - AppBar().preferredSize.height,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(40.0),
                child: Card(
                  color: Colors.white,
                  elevation: 10.0,
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Image.asset(answer),
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
                      parent: this,
                    );
                  }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Tile extends StatefulWidget {
  String imageAssetPath;
  String answer;
  bool selected;

  _gameScreenState parent;

  Tile({this.imageAssetPath, this.answer, this.selected, this.parent});

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
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: widget.selected ? (widget.answer.compareTo(widget.imageAssetPath) == 0 ? Image.asset('assets/images/colors.jpg') : Image.asset("assets/images/default.jpg")) : Image.asset(widget.imageAssetPath),
          ),
        ),
      ),
    );
  }
}
