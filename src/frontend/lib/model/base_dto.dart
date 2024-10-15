
abstract class BaseDTO {
  void fillFromJson(Map<String, dynamic> map);
  String toJson();
  String? getId();
}