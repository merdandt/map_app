import 'dart:convert';

Nominatim nominatimFromJson(String str) => Nominatim.fromJson(json.decode(str));

String nominatimToJson(Nominatim data) => json.encode(data.toJson());

class Nominatim {
  final int placeId;
  final String licence;
  final String osmType;
  final int osmId;
  final String lat;
  final String lon;
  final String displayName;
  final Address address;
  final List<String> boundingbox;

  Nominatim({
    required this.placeId,
    required this.licence,
    required this.osmType,
    required this.osmId,
    required this.lat,
    required this.lon,
    required this.displayName,
    required this.address,
    required this.boundingbox,
  });

  factory Nominatim.fromJson(Map<String, dynamic> json) => Nominatim(
        placeId: json["place_id"],
        licence: json["licence"],
        osmType: json["osm_type"],
        osmId: json["osm_id"],
        lat: json["lat"],
        lon: json["lon"],
        displayName: json["display_name"],
        address: Address.fromJson(json["address"]),
        boundingbox: List<String>.from(json["boundingbox"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "place_id": placeId,
        "licence": licence,
        "osm_type": osmType,
        "osm_id": osmId,
        "lat": lat,
        "lon": lon,
        "display_name": displayName,
        "address": address.toJson(),
        "boundingbox": List<dynamic>.from(boundingbox.map((x) => x)),
      };
}

class Address {
  final String amenity;
  final String road;
  final String neighbourhood;
  final String borough;
  final String city;
  final String iso31662Lvl4;
  final String postcode;
  final String country;
  final String countryCode;

  Address({
    required this.amenity,
    required this.road,
    required this.neighbourhood,
    required this.borough,
    required this.city,
    required this.iso31662Lvl4,
    required this.postcode,
    required this.country,
    required this.countryCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        amenity: json["amenity"],
        road: json["road"],
        neighbourhood: json["neighbourhood"],
        borough: json["borough"],
        city: json["city"],
        iso31662Lvl4: json["ISO3166-2-lvl4"],
        postcode: json["postcode"],
        country: json["country"],
        countryCode: json["country_code"],
      );

  Map<String, dynamic> toJson() => {
        "amenity": amenity,
        "road": road,
        "neighbourhood": neighbourhood,
        "borough": borough,
        "city": city,
        "ISO3166-2-lvl4": iso31662Lvl4,
        "postcode": postcode,
        "country": country,
        "country_code": countryCode,
      };
}
