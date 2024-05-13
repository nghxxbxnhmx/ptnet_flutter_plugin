import 'package:flutter_test/flutter_test.dart';
import 'package:ptnet_plugin/data.dart';
import 'package:ptnet_plugin/ptnet_plugin.dart';
import 'package:ptnet_plugin/ptnet_plugin_platform_interface.dart';
import 'package:ptnet_plugin/ptnet_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPtnetPluginPlatform
    with MockPlatformInterfaceMixin
    implements PtnetPluginPlatform {

  @override
  Future<String?> getPageLoadResult(String address) => Future.value("10.0");

  @override
  Future<PingDTO?> getPingResult(String address)  => Future.value(PingDTO(address: "zing.vn",ip:"127.0.0.1",time:10.12));

  @override
  Future<List<String>?> getDnsLookupResult(String address, String server) {
    // TODO: implement getDnsLookupResult
    throw UnimplementedError();
  }

  @override
  Future<PortDTO?> getPortScanResult(String address, int port, int timeout) {
    // TODO: implement getPortScanResult
    throw UnimplementedError();
  }

  @override
  Future<TraceHopDTO?> getTraceRouteResult(String address, int ttl) {
    // TODO: implement getTraceRouteResult
    throw UnimplementedError();
  }

  @override
  Future<List<WifiScanResultDTO>?> getWifiScanResult() {
    // TODO: implement getWifiScanResult
    throw UnimplementedError();
  }

  @override
  Future<WifiInfoDTO?> getWifiInfo() {
    // TODO: implement getWifiInfo
    throw UnimplementedError();
  }

  @override
  Future<TraceHopDTO?> getTraceRouteEndpoint(String address) {
    // TODO: implement getTraceRouteEndpoint
    throw UnimplementedError();
  }
}

void main() {
  final PtnetPluginPlatform initialPlatform = PtnetPluginPlatform.instance;

  test('$MethodChannelPtnetPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPtnetPlugin>());
  });

  test('getPlatformVersion', () async {
    PtnetPlugin ptnetPlugin = PtnetPlugin();
    MockPtnetPluginPlatform fakePlatform = MockPtnetPluginPlatform();
    PtnetPluginPlatform.instance = fakePlatform;

    expect(await ptnetPlugin.getPingResult("zing.vn"),
        PingDTO(address: "zing.vn", ip: "127.0.0.1", time: 10.12));
  });
}
