import 'package:data_provider/data_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'package:map_repository/src/models/models.dart';

extension Coordinates on Position {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

class MapRepository {
  static const ashgabatLatLng = LatLng(37.866820, 58.468703);

  static const urlTemplate = '${APIEdnPoints.baseUrl}/tile/{z}/{x}/{y}.png';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final _http = ApiClient();
  LocationPermission? permission;

  Future<GeoCodingim2?> getGeoCodingium(LatLng position) async {
    try {
      //
      // final bodyMap = <String, dynamic>{
      //   APIScheme.format: 'json',
      //   APIScheme.lat: '${position.latitude}',
      //   APIScheme.lon: '${position.longitude}',
      // };
      // final response = await _http.client.get<String>(
      //   APIEdnPoints.reverse,
      //   queryParameters: bodyMap,
      //   options: Options(contentType: Headers.jsonContentType),
      // );
      // if (response.statusCode == 200 && response.data != null) {
      //   final nominatim = nominatimFromJson(response.data!);
      //   return nominatim;
      // }

      // Asman
      final response = await _http.client.get<String>(
        APIEdnPoints.baseUrlAsman + APIEdnPoints.reverseAsman,
        queryParameters: {
          'lat': position.latitude.toString(),
          'lng': position.longitude.toString()
        },
      );
      if (response.statusCode == 200 && response.data != null) {
        final nominatim = nominatim2FromJson(response.data!);
        return nominatim;
      }
      return null;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RetrievedAddress>?> search(String street) async {
    try {
      final response = await _http.client.get<String>(
        APIEdnPoints.baseUrlAsman + APIEdnPoints.searchAsman,
        queryParameters: {
          APIScheme.street: street,
        },
      );
      if (response.statusCode == 200 && response.data != null) {
        final result = searchResultFromJson(response.data!);
        return result.data;
      }
      return null;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Position?> getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return null;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    return position;
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    try {
      serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return false;
      }
      permission = await _geolocatorPlatform.checkPermission();
      var result = false;
      switch (permission) {
        case LocationPermission.denied:
          result = await _handleDenied();
        case LocationPermission.deniedForever:
          result = await _handleDeniedForever();
        case LocationPermission.unableToDetermine:
          result = await _handleUnebleToDetermine();
        case LocationPermission.always:
          result = true;
        case LocationPermission.whileInUse:
          result = true;
      }
      return result;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _handleDenied() async {
    permission = await _geolocatorPlatform.requestPermission();
    if (permission == LocationPermission.unableToDetermine) return false;
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<bool> _handleDeniedForever() async {
    await Geolocator.openLocationSettings();
    permission = await _geolocatorPlatform.requestPermission();
    if (permission == LocationPermission.unableToDetermine) return false;
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<bool> _handleUnebleToDetermine() async {
    permission = await _geolocatorPlatform.requestPermission();
    if (permission == LocationPermission.unableToDetermine) return false;
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
}
