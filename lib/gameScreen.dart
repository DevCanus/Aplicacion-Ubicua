import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    tiles = getTiles();
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
      body: Container(
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
                    child: Image.asset("assets/images/user.png"),
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
  bool selected;

  _gameScreenState parent;

  Tile({this.imageAssetPath, this.selected, this.parent});

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
            child: widget.selected ? Image.asset("assets/images/default.jpg") : Image.asset(widget.imageAssetPath),
          ),
        ),
      ),
    );
  }
}
