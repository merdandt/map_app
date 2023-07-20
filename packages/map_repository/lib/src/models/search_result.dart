// To parse this JSON data, do
//
//     final searchResult = searchResultFromJson(jsonString);

import 'dart:convert';

import 'package:map_repository/map_repository.dart';

SearchResult searchResultFromJson(String str) =>
    SearchResult.fromJson(json.decode(str) as Map<String, dynamic>);

String searchResultToJson(SearchResult data) => json.encode(data.toJson());

class SearchResult {
  SearchResult({
    required this.success,
    required this.data,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        success: json['success'] as bool,
        data: List<RetrievedAddress>.from(
          (json['data'] as List<dynamic>)
              .map((e) => RetrievedAddress.fromJson(e as Map<String, dynamic>)),
        ),
      );
  final bool success;
  final List<RetrievedAddress> data;

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RetrievedAddress {
  RetrievedAddress({
    required this.placeId,
    required this.licence,
    required this.osmType,
    required this.osmId,
    required this.boundingbox,
    required this.lat,
    required this.lon,
    required this.displayName,
    required this.datumClass,
    required this.type,
    required this.importance,
    required this.address,
    required this.geojson,
  });

  factory RetrievedAddress.fromJson(Map<String, dynamic> json) =>
      RetrievedAddress(
        placeId: json['place_id'] as int,
        licence: json['licence'] as String,
        osmType: json['osm_type'] as String,
        osmId: json['osm_id'] as int,
        boundingbox:
            List<String>.from((json['boundingbox'] as Iterable).map((x) => x)),
        lat: json['lat'] as String,
        lon: json['lon'] as String,
        displayName: json['display_name'] as String,
        datumClass: json['class'] as String,
        type: json['type'] as String,
        importance: json['importance'] as double,
        address:
            AddressDetails.fromJson(json['address'] as Map<String, dynamic>),
        geojson: Geojson.fromJson(json['geojson'] as Map<String, dynamic>),
      );
  final int placeId;
  final String licence;
  final String osmType;
  final int osmId;
  final List<String> boundingbox;
  final String lat;
  final String lon;
  final String displayName;
  final String datumClass;
  final String type;
  final double importance;
  final AddressDetails address;
  final Geojson geojson;

  LatLng get latlng => LatLng(double.parse(lat), double.parse(lon));

  Map<String, dynamic> toJson() => {
        'place_id': placeId,
        'licence': licence,
        'osm_type': osmType,
        'osm_id': osmId,
        'boundingbox': List<dynamic>.from(boundingbox.map((x) => x)),
        'lat': lat,
        'lon': lon,
        'display_name': displayName,
        'class': datumClass,
        'type': type,
        'importance': importance,
        'address': address.toJson(),
        'geojson': geojson.toJson(),
      };
}

class AddressDetails {
  AddressDetails({
    required this.road,
    required this.neighbourhood,
    required this.borough,
    required this.city,
    required this.postcode,
    required this.country,
    required this.countryCode,
  });

  factory AddressDetails.fromJson(Map<String, dynamic> json) => AddressDetails(
        road: json['road'] as String,
        neighbourhood: json['neighbourhood'] as String,
        borough: json['borough'] as String,
        city: json['city'] as String,
        postcode: json['postcode'] as String,
        country: json['country'] as String,
        countryCode: json['country_code'] as String,
      );
  final String road;
  final String neighbourhood;
  final String borough;
  final String city;
  final String postcode;
  final String country;
  final String countryCode;

  Map<String, dynamic> toJson() => {
        'road': road,
        'neighbourhood': neighbourhood,
        'borough': borough,
        'city': city,
        'postcode': postcode,
        'country': country,
        'country_code': countryCode,
      };
}

class Geojson {
  Geojson({
    required this.type,
    required this.coordinates,
  });

  factory Geojson.fromJson(Map<String, dynamic> json) => Geojson(
        type: json['type'] as String,
        coordinates: List<List<double>>.from(
          (json['coordinates'] as Iterable)
              .map((x) => List<double>.from((x as Iterable).map((x) => x))),
        ),
      );
  final String type;
  final List<List<double>> coordinates;

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': List<dynamic>.from(
          coordinates.map((x) => List<dynamic>.from(x.map((x) => x))),
        ),
      };
}
