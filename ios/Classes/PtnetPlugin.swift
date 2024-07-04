import Flutter
import PTNetFramework

public class PtnetPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ptnet_plugin", binaryMessenger: registrar.messenger())
    let instance = PtnetPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let libraryHandler = LibraryHandler()

    switch call.method {
    case "getPlatformVersion":
      libraryHandler.getPlatformVersion { platformVersion in
        result(platformVersion)
      }
    case "getWifiInfo":
      libraryHandler.getWifiInfo { wifiInfo in
        result(wifiInfo)
      }
    case "getPingResult":
      if let arguments = call.arguments as? [String: Any],
         let address = arguments["address"] as? String {
        libraryHandler.pingAddress(address: address) { pingResult in
          result(pingResult)
        }
      } else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing address argument", details: nil))
      }
    case "getPageLoadResult":
      if let arguments = call.arguments as? [String: Any],
         let address = arguments["address"] as? String {
        libraryHandler.loadPage(address: address) { pageLoadResult in
          result(pageLoadResult)
        }
      } else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing address argument", details: nil))
      }
    case "getDnsLookupResult":
      if let arguments = call.arguments as? [String: Any],
         let domainName = arguments["address"] as? String,
         let dnsServer = arguments["server"] as? String {
        libraryHandler.resolveDomain(domainName: domainName, dnsServer: dnsServer) { dnsLookupResult in
          result(dnsLookupResult)
        }
      } else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing domainName or dnsServer argument", details: nil))
      }
    case "getPortScanResult":
      if let arguments = call.arguments as? [String: Any],
         let address = arguments["address"] as? String,
         let port = arguments["port"] as? Int,
         let timeout = arguments["timeout"] as? Double {
        libraryHandler.scanPort(address: address, port: port, timeout: timeout) { portScanResult in
          result(portScanResult)
        }
      } else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing address, port, or timeout argument", details: nil))
      }
    case "getTraceRouteResult":
      if let arguments = call.arguments as? [String: Any],
         let host = arguments["address"] as? String,
         let ttl = arguments["ttl"] as? Int {
        libraryHandler.traceRoute(host: host, ttl: ttl) { traceRouteResult in
          result(traceRouteResult)
        }
      } else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing host or ttl argument", details: nil))
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
