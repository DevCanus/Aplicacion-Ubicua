import 'package:proyecto/utils/tileModel.dart';

List<TileModel> getTiles()
{
  List<TileModel> tiles = new List<TileModel>();
  TileModel model = new TileModel();

  //1
  model.setImage("assets/images/colors.jpg");
  model.setSelected(false);
  tiles.add(model);

  //2
  model.setImage("assets/images/user.png");
  model.setSelected(false);
  tiles.add(model);

  //3
  model.setImage("assets/images/user.png");
  model.setSelected(false);
  tiles.add(model);

  //4
  model.setImage("assets/images/user.png");
  model.setSelected(false);
  tiles.add(model);

  //5
  model.setImage("assets/images/user.png");
  model.setSelected(false);
  tiles.add(model);

  //6
  model.setImage("assets/images/user.png");
  model.setSelected(false);
  tiles.add(model);

  return tiles;
}