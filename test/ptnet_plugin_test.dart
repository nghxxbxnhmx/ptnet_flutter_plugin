import 'package:flutter_test/flutter_test.dart';
import 'package:ptnet_plugin/ptnet_plugin.dart';
import 'package:ptnet_plugin/ptnet_plugin_platform_interface.dart';
import 'package:ptnet_plugin/ptnet_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPtnetPluginPlatform
    with MockPlatformInterfaceMixin
    implements PtnetPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
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

    expect(await ptnetPlugin.getPlatformVersion(), '42');
  });
}
