import Flutter
import Foundation
//import PTNetFramework

public class PtnetPlugin: NSObject, FlutterPlugin {
    let jsonEncoder = JSONEncoder()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ptnet_plugin", binaryMessenger: registrar.messenger())
        let instance = PtnetPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "getPingResult":
            guard let arguments = call.arguments as? [String: Any],
                  let address = arguments["address"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Argument 'address' not found", details: nil))
                return
            }

//            let pingService = PingService(dnsLookUpService: DnsLookUpService())
//            pingService.execute(address: address) { pingDTO in
//                do {
//                    let jsonData = try JSONEncoder().encode(pingDTO)
//                    if let jsonString = String(data: jsonData, encoding: .utf8) {
//                        result(jsonString)
//                    } else {
//                        result(FlutterError(code: "JSON_ENCODING_ERROR", message: "Failed to encode JSON string", details: nil))
//                    }
//                } catch {
//                    result(FlutterError(code: "JSON_ENCODING_ERROR", message: "Failed to encode JSON: \(error)", details: nil))
//                }
//            }
            
            result("{\"address\": \"\(address)\", \"ip\": \"8.8.8.8\", \"time\": 8.888}")
        case "greeting":
            result("Hello world from iOS ak nha!!")
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
