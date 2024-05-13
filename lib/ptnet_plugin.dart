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

  Future<String?> getPageLoadResult(String address) {
    return PtnetPluginPlatform.instance.getPageLoadResult(address);
  }

  Future<List<String>?> getDnsLookupResult(String address, String server) {
    return PtnetPluginPlatform.instance
        .getDnsLookupResult(address, server)
        .then((List<String>? results) {
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

  Future<TraceHopDTO?> getTraceRouteEndpoint(String address) {
    return PtnetPluginPlatform.instance
        .getTraceRouteEndpoint(address)
        .then((TraceHopDTO? results) {
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

  Future<TraceHopDTO?> getTraceRouteResult(String address, int ttl) {
    return PtnetPluginPlatform.instance
        .getTraceRouteResult(address, ttl)
        .then((TraceHopDTO? results) {
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

  Future<List<WifiScanResultDTO>?> getWifiScanResult() {
    return PtnetPluginPlatform.instance
        .getWifiScanResult()
        .then((List<WifiScanResultDTO>? results) {
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

  Future<WifiInfoDTO?> getWifiInfo() {
    return PtnetPluginPlatform.instance
        .getWifiInfo()
        .then((WifiInfoDTO? results) {
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
