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
  Future<PageLoadDTO?> getPageLoadResult(String address) async {
    try {
      var dataToPass = <String, dynamic>{'address': address};
      final jsonResult = await methodChannel.invokeMethod<String>(
          'getPageLoadResult', dataToPass);

      if (jsonResult != null) {
        final Map<String, dynamic> parsedJson = json.decode(jsonResult);
        return PageLoadDTO.fromJson(parsedJson);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<AnswerDTO>?> getDnsLookupResult(
      String address, String server) async {
    try {
      var dataToPass = <String, dynamic>{'address': address, 'server': server};
      final jsonResult = await methodChannel.invokeMethod<String>(
          'getDnsLookupResult', dataToPass);

      if (jsonResult != null) {
        final List<dynamic> list = json.decode(jsonResult);
        final List<AnswerDTO> answerDTOs =
            list.map((item) => AnswerDTO.fromJson(item)).toList();
        return answerDTOs;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<PortDTO?> getPortScanResult(String address, int port,int timeout) async {
    try {
      var dataToPass = <String, dynamic>{'address': address, 'port': port, 'timeout': timeout};
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
}
