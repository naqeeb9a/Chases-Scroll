import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static void launchAddress(String address) async {
    if (await canLaunch(address)) {
      await launch(address);
    } else {
      print('Could not launch $address');
    }
  }

  static void launchMapOnAddress(String address) async {
    String query = Uri.encodeFull(address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if (await launch(googleUrl)) {
      await canLaunch(googleUrl);
    }
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

class URLLauncher {
  URLLauncher._();

  static Future<void> launchURL(String url) async {
    if (await launch(url)) {
      await canLaunch(url);
    } else {
      throw 'Could not open the map.';
    }
  }
}
