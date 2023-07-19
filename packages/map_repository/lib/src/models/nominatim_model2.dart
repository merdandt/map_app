// To parse this JSON data, do
//
//     final nominatim2 = nominatim2FromJson(jsonString);

import 'dart:convert';

GeoCodingim2 nominatim2FromJson(String str) =>
    GeoCodingim2.fromJson(json.decode(str) as Map<String, dynamic>);

String nominatim2ToJson(GeoCodingim2 data) => json.encode(data.toJson());

class GeoCodingim2 {
  GeoCodingim2({
    required this.success,
    required this.data,
  });

  factory GeoCodingim2.fromJson(Map<String, dynamic> json) => GeoCodingim2(
        success: json['success'] as bool,
        data: Data.fromJson(json['data'] as Map<String, dynamic>),
      );
  final bool success;
  final Data data;

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data.toJson(),
      };
}

class Data {
  Data({
    required this.placeId,
    required this.licence,
    required this.osmType,
    required this.osmId,
    required this.lat,
    required this.lon,
    required this.displayName,
    required this.address,
    required this.boundingbox,
    required this.asmanService,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        placeId: json['place_id'] as int,
        licence: json['licence'] as String,
        osmType: json['osm_type'] as String,
        osmId: json['osm_id'] as int,
        lat: json['lat'] as String,
        lon: json['lon'] as String,
        displayName: json['display_name'] as String,
        address: Address.fromJson(json['address'] as Map<String, dynamic>),
        boundingbox:
            List<String>.from((json['boundingbox'] as Iterable).map((x) => x)),
        asmanService: AsmanService.fromJson(
          json['asman_service'] as Map<String, dynamic>,
        ),
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
  final AsmanService asmanService;

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
        'asman_service': asmanService.toJson(),
      };
}

class Address {
  Address({
    required this.state,
    required this.postcode,
    required this.country,
    required this.countryCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        state: json['state'].toString(),
        postcode: json['postcode'].toString(),
        country: json['country'].toString(),
        countryCode: json['country_code'].toString(),
      );
  final String state;
  final String postcode;
  final String country;
  final String countryCode;

  Map<String, dynamic> toJson() => {
        'state': state,
        'postcode': postcode,
        'country': country,
        'country_code': countryCode,
      };
}

class AsmanService {
  AsmanService({
    required this.message,
    required this.isAvailable,
  });

  factory AsmanService.fromJson(Map<String, dynamic> json) => AsmanService(
        message: json['message'].toString(),
        isAvailable: json['is_available'] as bool,
      );
  final String message;
  final bool isAvailable;

  Map<String, dynamic> toJson() => {
        'message': message,
        'is_available': isAvailable,
      };
}
