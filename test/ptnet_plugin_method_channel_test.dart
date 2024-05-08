import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ptnet_plugin/data.dart';
import 'package:ptnet_plugin/ptnet_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelPtnetPlugin platform = MethodChannelPtnetPlugin();
  const MethodChannel channel = MethodChannel('ptnet_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return PingDTO(address: "zing.vn", ip: "127.0.0.1", time: 10.12);
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPingResult', () async {
    expect(await platform.getPingResult("zing.vn"), PingDTO(address: "zing.vn", ip: "127.0.0.1", time: 10.12));
  });
}
