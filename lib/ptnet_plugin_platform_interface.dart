import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'data.dart';
import 'ptnet_plugin_method_channel.dart';

abstract class PtnetPluginPlatform extends PlatformInterface {
  /// Constructs a PtnetPluginPlatform.
  PtnetPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static PtnetPluginPlatform _instance = MethodChannelPtnetPlugin();

  /// The default instance of [PtnetPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelPtnetPlugin].
  static PtnetPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PtnetPluginPlatform] when
  /// they register themselves.
  static set instance(PtnetPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<PingDTO?> getPingResult(String address) {
    throw UnimplementedError('pingResult() has not been implemented.');
  }

  Future<PageLoadDTO?> getPageLoadResult(String address) {
    throw UnimplementedError('pageLoadResult() has not been implemented.');
  }

  Future<List<AnswerDTO>?> getDnsLookupResult(String address, String server) {
    throw UnimplementedError('dnsLookupResult() has not been implemented.');
  }
}
