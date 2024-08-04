import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<String> getCurrentAddress() async {
    try {
      // Verifica a permissão de localização
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return 'Location permissions are denied';
      } else if (permission == LocationPermission.deniedForever) {
        return 'Location permissions are permanently denied';
      }

      // Obtém a localização atual
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Converte a posição em um endereço
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];

      // Formata o endereço como string
      String address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

      return address;
    } catch (e) {
      return 'Failed to get location: $e';
    }
  }
}
