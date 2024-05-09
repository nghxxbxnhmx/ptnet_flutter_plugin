import 'data.dart';
import 'ptnet_plugin_platform_interface.dart';

class PtnetPlugin {
  Future<PingDTO?> getPingResult(String address) {
    return PtnetPluginPlatform.instance
        .getPingResult(address)
        .then((PingDTO? result) {
      // Check if result is not null
      if (result != null) {
        return result;
      } else {
        return null;
      }
    }).catchError((error) {
      return null;
    });
  }

  Future<PageLoadDTO?> getPageLoadResult(String address) {
    return PtnetPluginPlatform.instance
        .getPageLoadResult(address)
        .then((PageLoadDTO? result) {
      // Check if result is not null
      if (result != null) {
        return result;
      } else {
        return null;
      }
    }).catchError((error) {
      return null;
    });
  }

  Future<List<AnswerDTO>?> getDnsLookupResult(String address, String server) {
    return PtnetPluginPlatform.instance
        .getDnsLookupResult(address, server)
        .then((List<AnswerDTO>? results) {
      // Check if result is not null
      if (results != null) {
        return results;
      } else {
        return null;
      }
    }).catchError((error) {
      return null;
    });
  }

  Future<PortDTO?> getPortScanResult(String address, int port, int timeout) {
    return PtnetPluginPlatform.instance
        .getPortScanResult(address, port, timeout)
        .then((PortDTO? results) {
      // Check if result is not null
      if (results != null) {
        return results;
      } else {
        return null;
      }
    }).catchError((error) {
      return null;
    });
  }
}
