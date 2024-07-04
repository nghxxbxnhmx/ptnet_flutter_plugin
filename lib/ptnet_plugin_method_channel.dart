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
  Future<String?> getPlatformVersion() async {
    try {
      final String? version =
          await methodChannel.invokeMethod<String>('getPlatformVersion');
      print('Platform version: $version');
      return version;
    } catch (e) {
      print('Error getting platform version: $e');
      return null;
    }
  }

  @override
  Future<PingDTO?> getPingResult(String address) async {
    try {
      var dataToPass = <String, dynamic>{'address': address};
      final jsonResult =
          await methodChannel.invokeMethod<String>('getPingResult', dataToPass);

      if (jsonResult != null) {
        final Map<String, dynamic> parsedJson = json.decode(jsonResult);
        final PingDTO pingDTO = PingDTO.fromJson(parsedJson);
        print('Ping result: $pingDTO');
        return pingDTO;
      } else {
        print('Ping result is null');
        return null;
      }
    } catch (e) {
      print('Error getting ping result: $e');
      return null;
    }
  }

// fix that function to return PageLoadDTO
  @override
  Future<PageLoadDTO?> getPageLoadResult(String url) async {
    try {
      var dataToPass = <String, dynamic>{'address': url};
      final jsonResult = await methodChannel.invokeMethod<String>(
          'getPageLoadResult', dataToPass);

      if (jsonResult != null) {
        final Map<String, dynamic> parsedJson = json.decode(jsonResult);
        final PageLoadDTO pageLoadDTO = PageLoadDTO.fromJson(parsedJson);
        print('Page load result: $pageLoadDTO');
        return pageLoadDTO;
      } else {
        print('Page load result is null');
        return null;
      }
    } catch (e) {
      print('Error getting page load result: $e');
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
        print('DNS lookup results: $dnsResults');
        return dnsResults;
      } else {
        print('DNS lookup result is null');
        return null;
      }
    } catch (e) {
      print('Error getting DNS lookup result: $e');
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
        print('Port scan result: $portDTO');
        return portDTO;
      } else {
        print('Port scan result is null');
        return null;
      }
    } catch (e) {
      print('Error getting port scan result: $e');
      return null;
    }
  }

  @override
  Future<TraceHopDTO?> getTraceRouteEndpoint(String address) async {
    try {
      var dataToPass = <String, dynamic>{'address': address};
      final jsonResult = await methodChannel.invokeMethod<String>(
          'getTraceRouteResult', dataToPass);

      if (jsonResult != null) {
        final Map<String, dynamic> parsedJson = json.decode(jsonResult);
        final TraceHopDTO traceHopDTO = TraceHopDTO.fromJson(parsedJson);
        print('Trace route endpoint result: $traceHopDTO');
        return traceHopDTO;
      } else {
        print('Trace route endpoint result is null');
        return null;
      }
    } catch (e) {
      print('Error getting trace route endpoint result: $e');
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
        print('Trace route result: $traceHopDTO');
        return traceHopDTO;
      } else {
        print('Trace route result is null');
        return null;
      }
    } catch (e) {
      print('Error getting trace route result: $e');
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
        print('Wi-Fi scan results: $wifiScanResults');
        return wifiScanResults;
      } else {
        print('Wi-Fi scan result is null');
        return null;
      }
    } catch (e) {
      print('Error getting Wi-Fi scan result: $e');
      return null;
    }
  }

  @override
  Future<WifiInfoDTO?> getWifiInfo() async {
    try {
      var dataToPass = <String, dynamic>{};
      final jsonResult =
          await methodChannel.invokeMethod<String>('getWifiInfo', dataToPass);

      if (jsonResult != null) {
        final Map<String, dynamic> parsedJson = json.decode(jsonResult);
        final WifiInfoDTO wifiInfoDTO = WifiInfoDTO.fromJson(parsedJson);
        print('Wi-Fi info result: $wifiInfoDTO');
        return wifiInfoDTO;
      } else {
        print('Wi-Fi info result is null');
        return null;
      }
    } catch (e) {
      print('Error getting Wi-Fi info result: $e');
      return null;
    }
  }
}
