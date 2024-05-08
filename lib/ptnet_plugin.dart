
import 'ptnet_plugin_platform_interface.dart';

class PtnetPlugin {
  Future<String?> getPlatformVersion() {
    return PtnetPluginPlatform.instance.getPlatformVersion();
  }
}
