import 'package:data_provider/data_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_repository/src/models/nominatim_model2.dart';

extension Coordinates on Position {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

class MapRepository {
  static const almatyPosition = Position(
    latitude: 43.238949,
    longitude: 76.889709,
    timestamp: null,
    altitude: 3000,
    accuracy: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  );
  static const almatyLatLng = LatLng(37.866820, 58.468703);
  // LatLng(
  //   43.238949,
  //   76.889709,
  // );

  static const urlTemplate = '${APIEdnPoints.baseUrl}/tile/{z}/{x}/{y}.png';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final _http = ApiClient();
  LocationPermission? permission;

  Future<Nominatim2?> getNominatium(LatLng position) async {
    try {
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
        'https://customers.asmanexpress.com/api/services/address/nominatim/reverse',
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
    // Test if location services are enabled.
    try {
      serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return false;
      }
      permission = await _geolocatorPlatform.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await _geolocatorPlatform.requestPermission();
        if (permission == LocationPermission.denied) {
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
