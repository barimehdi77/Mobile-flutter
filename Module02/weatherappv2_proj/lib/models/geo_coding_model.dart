import 'package:weatherappv2_proj/models/address_model.dart';

class GeoCodingModel {
  int id;
  String name;
  double latitude;
  double longitude;
  double elevation;
  String countryCode;
  String timezone;
  String country;

  GeoCodingModel({
    required this.country,
    required this.countryCode,
    required this.elevation,
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.timezone,
  });

  factory GeoCodingModel.fromJson(Map parseData) {
    return GeoCodingModel(
      country: parseData['country'],
      countryCode: parseData['country_code'],
      elevation: parseData['elevation'],
      id: parseData['id'],
      latitude: parseData['latitude'],
      longitude: parseData['longitude'],
      name: parseData['name'],
      timezone: parseData['timezone'],
    );
  }

  static List<GeoCodingModel> fromJsonList(List list) {
    return list.map((item) => GeoCodingModel.fromJson(item)).toList();
  }
}
