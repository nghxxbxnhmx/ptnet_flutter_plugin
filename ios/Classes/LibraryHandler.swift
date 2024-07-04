import Foundation
import PTNetFramework
import SwiftUI

public class LibraryHandler {
    private let jsonEncoder = JSONEncoder()
    private let nsLookup = NsLookup()
    private let pageLoadTimer =  PageLoadTimer()
    private let pingICMP = PingICMP()
    private let portScan = PortScan()
    private let traceroute = Traceroute()
    
    public init() {}
    
    public func getWifiInfo(completion: @escaping (String) -> Void) {
        let ipConfig = IpConfig()
        ipConfig.getIpConfigInfo(completion: { ipConfigDTO in
            let jsonData = try! self.jsonEncoder.encode(ipConfigDTO)
            let stringData = String(data: jsonData, encoding: .utf8)
            completion(stringData ?? "")
            
        })
    }
    
    public func loadPage(address: String, completion: @escaping (String) -> Void) {
        let pageLoadDTO = pageLoadTimer.execute(address: address)
        let jsonString = try? jsonEncoder.encode(pageLoadDTO)
        let stringData = jsonString.flatMap { String(data: $0, encoding: .utf8) } ?? ""
        completion(stringData)
    }
    
    public func resolveDomain(domainName: String, dnsServer: String, completion: @escaping (String) -> Void) {
        nsLookup.execute(domainName: domainName, dnsServer: dnsServer, completion: { results in
            let jsonData = try! self.jsonEncoder.encode(results)
            let stringData = String(data: jsonData, encoding: .utf8)
            completion(stringData ?? "[]")
        })
    }
    
    public func pingAddress(address: String, completion: @escaping (String) -> Void) {
        pingICMP.execute(address: address) { pingDTO in
            let jsonData = try! self.jsonEncoder.encode(pingDTO)
            let stringData = String(data: jsonData, encoding: .utf8)
            completion(stringData ?? "")
            
        }
    }
    
    public func scanPort(address: String, port: Int, timeout: Double, completion: @escaping (String) -> Void) {
        let portDTO = portScan.portScan(address: address, port: port, timeOut: timeout)
        let jsonData = try! self.jsonEncoder.encode(portDTO)
        let stringData = String(data: jsonData, encoding: .utf8)
        completion(stringData ?? "")
    }
    
    public func traceRoute(host: String, ttl: Int, completion: @escaping (String) -> Void) {
        traceroute.trace(host: host, ttl: ttl, completion: { hop in
            let jsonData = try! self.jsonEncoder.encode(hop)
            let stringData = String(data: jsonData, encoding: .utf8)
            completion(stringData ?? "")
        })
    }
    
    public func getPlatformVersion(completion: @escaping (String) -> Void) {
        let stringData = "iOS \(UIDevice.current.systemVersion)"
        completion(stringData)
    }
}
