class TileModel {
  String imageAssetPath;
  bool selected;

  List<TileModel> tilelist = new List<TileModel>();

  TileModel({this.imageAssetPath, this.selected});

  void setImage(String image) { imageAssetPath = image; }
  void setSelected(bool selection) { selected = selection; }
  String getImage() { return imageAssetPath; }
  bool isSelected() {return selected; }
}