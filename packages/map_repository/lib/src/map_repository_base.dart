import 'package:data_provider/data_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_repository/src/models/nominatim_model.dart';

class MapRepository {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final _http = ApiClient(baseUrl: APIEdnPoints.baseUrl);

  Future<Nominatim?> getNominatium(LatLng position) async {
    try {
      final Map<String, dynamic> bodyMap = <String, dynamic>{
        APIScheme.format: 'json',
        APIScheme.lat: '${position.latitude}',
        APIScheme.lon: '${position.longitude}',
      };
      final response = await _http.client.get(
        APIEdnPoints.reverse,
        queryParameters: bodyMap,
        options: Options(contentType: Headers.jsonContentType),
      );
      if (response.statusCode == 200) {
        final nominatim = nominatimFromJson(response.data);
        return nominatim;
      }
      return null;
    } on DioException catch (e) {
      throw e;
    } catch (e) {
      throw e;
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
  }
}
