import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

// Future<String> getAddressFromLatLng(Position position) async {
//   String currentAddress = '';
// List<Placemark> placemarks  await placemarkFromCoordinates(position.latitude, position.longitude)
//       .then((List<Placemark> placemarks) {
//     Placemark place = placemarks[0];
//     currentAddress =
//         '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
//     log(currentAddress);
//       return currentAddress;
//   }).catchError((e) {
//     debugPrint(e);
//   });
//   return currentAddress;
// }

Future<Placemark> getAddressFromLatLng(Position position) async {
  List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  Placemark place = placemarks[0];

  return place;
}

Future getCurrentPosition() async {
  final hasPermission = await handleLocationPermission();
  if (!hasPermission) return;

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  Placemark currentAddress = await getAddressFromLatLng(position);

  return currentAddress.toJson();
}

Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ToastResp.toastMsgError(
        resp: "Location Services are disabled. Please enable the services");
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ToastResp.toastMsgError(resp: "Location Permission is denied");
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ToastResp.toastMsgError(
        resp:
            "Location Services are permenantly denied. Please enable the services");
    return false;
  }
  return true;
}
