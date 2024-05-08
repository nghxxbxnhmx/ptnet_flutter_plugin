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
}
