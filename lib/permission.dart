import 'package:permission_handler/permission_handler.dart';

class PermissionResquest{
  Future<void> requestPermission() async {
    // Request location permission -> find near wifi
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.nearbyWifiDevices,
    ].request();

    if (statuses[Permission.location]!.isGranted) {
      // Permission for location is granted
    } else {
      // Handle the case when permission is denied
    }
  }
}