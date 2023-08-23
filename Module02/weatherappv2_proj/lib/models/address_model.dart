class AddressModel {
  String road;
  String suburb;
  String city;
  String county;
  String stateDistrict;
  String region;
  String postcode;
  String country;
  String countryCode;

  AddressModel({
    required this.city,
    required this.country,
    required this.countryCode,
    required this.county,
    required this.postcode,
    required this.region,
    required this.road,
    required this.stateDistrict,
    required this.suburb,
  });

  factory AddressModel.fromJSON(Map parseData) {
    return AddressModel(
      city: parseData['city'],
      country: parseData['country'],
      countryCode: parseData['country_code'],
      county: parseData['county'],
      postcode: parseData['postcode'],
      region: parseData['region'],
      road: parseData['road'],
      stateDistrict: parseData['state_district'],
      suburb: parseData['suburb'],
    );
  }
}
