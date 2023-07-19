/// Abstract class for structure and handle
/// all endpoints in the application
abstract class APIEdnPoints {
  /// Base url of nominatim
  static const baseUrl = 'https://nominatim.openstreetmap.org';

  /// Base url of Asman geocoding
  static const baseUrlAsman = 'https://customers.asmanexpress.com';

  /// reverse api for v1
  static const reverse = 'reverse.php';

  /// reverse Asman api for v1
  static const reverseAsman = '/api/services/address/nominatim/reverse';

  /// search Asman for v1
  static const searchAsman = '/api/services/address/nominatim/search';
}
