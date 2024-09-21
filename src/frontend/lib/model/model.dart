abstract class Model {
  void fillFromJson(Map<String, dynamic> map);
  String toJson();
  String getId();
}