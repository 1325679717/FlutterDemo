class MovieInfo{
  String _name;

  String _actor;

  String _avtar;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get actor => _actor;

  String get avtar => _avtar;

  set avtar(String value) {
    _avtar = value;
  }

  set actor(String value) {
    _actor = value;
  }
  MovieInfo.fromMap(Map<String,dynamic> map){
    _name = map["title"];
    _actor = map["casts"][0]["name"];
    _avtar = map["casts"][0]["avatars"]["medium"];

  }

}