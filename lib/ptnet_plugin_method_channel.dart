import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'data.dart';
import 'ptnet_plugin_platform_interface.dart';

/// An implementation of [LibrariespluginPlatform] that uses method channels.
class MethodChannelPtnetPlugin extends PtnetPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ptnet_plugin');

  @override
  Future<PingDTO?> getPingResult(String address) async {
    try {
      var dataToPass = <String, dynamic>{'address': address};
      final jsonResult =
          await methodChannel.invokeMethod<String>('getPingResult', dataToPass);

      if (jsonResult != null) {
        final Map<String, dynamic> parsedJson = json.decode(jsonResult);
        final PingDTO pingDTO = PingDTO.fromJson(parsedJson);
        return pingDTO;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> getPageLoadResult(String address) async {
    try {
      var dataToPass = <String, dynamic>{'address': address};
      final jsonResult = await methodChannel.invokeMethod<String>(
          'getPageLoadResult', dataToPass);

      if (jsonResult != null) {
        return jsonResult;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<String>?> getDnsLookupResult(
      String address, String server) async {
    try {
      var dataToPass = <String, dynamic>{'address': address, 'server': server};
      final jsonResult = await methodChannel.invokeMethod<String>(
          'getDnsLookupResult', dataToPass);

      if (jsonResult != null) {
        final List<dynamic> list = json.decode(jsonResult);
        final List<String> dnsResults = [];
        for (var element in list) {
          dnsResults.add(element);
        }
        return dnsResults;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<PortDTO?> getPortScanResult(
      String address, int port, int timeout) async {
    try {
      var dataToPass = <String, dynamic>{
        'address': address,
        'port': port,
        'timeout': timeout
      };
      final jsonResult = await methodChannel.invokeMethod<String>(
          'getPortScanResult', dataToPass);

      if (jsonResult != null) {
        final Map<String, dynamic> parsedJson = json.decode(jsonResult);
        final PortDTO portDTO = PortDTO.fromJson(parsedJson);
        return portDTO;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<TraceHopDTO?> getTraceRouteResult(String address, int ttl) async {
    try {
      var dataToPass = <String, dynamic>{'address': address, 'ttl': ttl};
      final jsonResult = await methodChannel.invokeMethod<String>(
          'getTraceRouteResult', dataToPass);

      if (jsonResult != null) {
        final Map<String, dynamic> parsedJson = json.decode(jsonResult);
        final TraceHopDTO traceHopDTO = TraceHopDTO.fromJson(parsedJson);
        return traceHopDTO;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<WifiScanResultDTO>?> getWifiScanResult() async {
    try {
      var dataToPass = <String, dynamic>{};
      final jsonResult = await methodChannel.invokeMethod<String>(
          'getWifiScanResult', dataToPass);

      if (jsonResult != null) {
        final List<dynamic> list = json.decode(jsonResult);
        final List<WifiScanResultDTO> wifiScanResults = [];
        for (var element in list) {
          wifiScanResults.add(WifiScanResultDTO.fromJson(element));
        }
        return wifiScanResults;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<WifiInfoDTO?> getWifiInfo() async {
    try {
      var dataToPass = <String, dynamic>{};
      final jsonResult = await methodChannel.invokeMethod<String>(
          'getWifiInfo', dataToPass);

      if (jsonResult != null) {
        final Map<String, dynamic> parsedJson = json.decode(jsonResult);
        final WifiInfoDTO wifiInfoDTO = WifiInfoDTO.fromJson(parsedJson);
        return wifiInfoDTO;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
