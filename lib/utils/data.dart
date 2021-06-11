import 'package:proyecto/utils/tileModel.dart';

List<TileModel> getTiles()
{
  List<TileModel> tiles = new List<TileModel>();
  TileModel model = new TileModel();

  //1
  model.setImage("assets/images/circle.jpg");
  model.setSelected(false);
  tiles.add(model);

  //2
  model = new TileModel();
  model.setImage("assets/images/dimond.jpg");
  model.setSelected(false);
  tiles.add(model);

  //3
  model = new TileModel();
  model.setImage("assets/images/heart.jpg");
  model.setSelected(false);
  tiles.add(model);

  //4
  model = new TileModel();
  model.setImage("assets/images/hexagon.jpg");
  model.setSelected(false);
  tiles.add(model);

  //5
  model = new TileModel();
  model.setImage("assets/images/star.jpg");
  model.setSelected(false);
  tiles.add(model);

  //6
  model = new TileModel();
  model.setImage("assets/images/pentagon.jpg");
  model.setSelected(false);
  tiles.add(model);

  return tiles;
}

List<TileModel> getHalfs()
{
  List<TileModel> tiles = new List<TileModel>();
  TileModel model = new TileModel();

  //1
  model.setImage("assets/images/circle_half.jpg");
  model.setSelected(false);
  tiles.add(model);

  //2
  model = new TileModel();
  model.setImage("assets/images/dimond_half.jpg");
  model.setSelected(false);
  tiles.add(model);

  //3
  model = new TileModel();
  model.setImage("assets/images/heart_half.jpg");
  model.setSelected(false);
  tiles.add(model);

  //4
  model = new TileModel();
  model.setImage("assets/images/hexagon_half.jpg");
  model.setSelected(false);
  tiles.add(model);

  //5
  model = new TileModel();
  model.setImage("assets/images/star_half.jpg");
  model.setSelected(false);
  tiles.add(model);

  //6
  model = new TileModel();
  model.setImage("assets/images/pentagon_half.jpg");
  model.setSelected(false);
  tiles.add(model);

  return tiles;
}