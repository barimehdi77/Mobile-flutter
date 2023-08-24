class GeoCodingModel {
  int id;
  String name;
  double latitude;
  double longitude;
  double elevation;
  String countryCode;
  String timezone;
  String country;
  String admin1;

  GeoCodingModel({
    required this.country,
    required this.countryCode,
    required this.elevation,
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.timezone,
    required this.admin1,
  });

  factory GeoCodingModel.fromJson(Map parseData) {
    return GeoCodingModel(
      country: parseData['country'] ?? "",
      countryCode: parseData['country_code'] ?? "",
      elevation: parseData['elevation'] ?? 0,
      id: parseData['id'] ?? 0,
      latitude: parseData['latitude'] ?? 0,
      longitude: parseData['longitude'] ?? 0,
      name: parseData['name'] ?? "",
      timezone: parseData['timezone'] ?? "",
      admin1: parseData['admin1'] ?? "",
    );
  }

  static List<GeoCodingModel> fromJsonList(List list) {
    print("list passed to fromJsonList");
    print(list);
    List<GeoCodingModel> convertList =
        list.map((item) => GeoCodingModel.fromJson(item)).toList();
    print("after converting list");
    print(convertList);

    return convertList;
  }
}
