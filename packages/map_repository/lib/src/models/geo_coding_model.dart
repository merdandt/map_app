import 'dart:convert';

GeoCodingim nominatimFromJson(String str) =>
    GeoCodingim.fromJson(json.decode(str) as Map<String, dynamic>);

String nominatimToJson(GeoCodingim data) => json.encode(data.toJson());

class GeoCodingim {
  GeoCodingim({
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

  factory GeoCodingim.fromJson(Map<String, dynamic> json) => GeoCodingim(
        placeId: json['place_id'] as int,
        licence: json['licence'].toString(),
        osmType: json['osm_type'].toString(),
        osmId: json['osm_id'] as int,
        lat: json['lat'].toString(),
        lon: json['lon'].toString(),
        displayName: json['display_name'].toString(),
        address: Address.fromJson(json['address'] as Map<String, dynamic>),
        boundingbox:
            List<String>.from((json['boundingbox'] as Iterable).map((x) => x)),
      );
  final int placeId;
  final String licence;
  final String osmType;
  final int osmId;
  final String lat;
  final String lon;
  final String displayName;
  final Address address;
  final List<String> boundingbox;

  Map<String, dynamic> toJson() => {
        'place_id': placeId,
        'licence': licence,
        'osm_type': osmType,
        'osm_id': osmId,
        'lat': lat,
        'lon': lon,
        'display_name': displayName,
        'address': address.toJson(),
        'boundingbox': List<dynamic>.from(boundingbox.map((x) => x)),
      };
}

class Address {
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
        amenity: json['amenity'].toString(),
        road: json['road'].toString(),
        neighbourhood: json['neighbourhood'].toString(),
        borough: json['borough'].toString(),
        city: json['city'].toString(),
        iso31662Lvl4: json['ISO3166-2-lvl4'].toString(),
        postcode: json['postcode'].toString(),
        country: json['country'].toString(),
        countryCode: json['country_code'].toString(),
      );
  final String amenity;
  final String road;
  final String neighbourhood;
  final String borough;
  final String city;
  final String iso31662Lvl4;
  final String postcode;
  final String country;
  final String countryCode;

  Map<String, dynamic> toJson() => {
        'amenity': amenity,
        'road': road,
        'neighbourhood': neighbourhood,
        'borough': borough,
        'city': city,
        'ISO3166-2-lvl4': iso31662Lvl4,
        'postcode': postcode,
        'country': country,
        'country_code': countryCode,
      };
}
