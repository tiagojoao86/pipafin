abstract class JsonConverterAdapter<T> {
  T fromJson(Map<String, dynamic> map);
  String toJson();
}