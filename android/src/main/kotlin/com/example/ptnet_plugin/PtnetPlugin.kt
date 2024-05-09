package com.example.ptnet_plugin

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** PtnetPlugin */
class PtnetPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ptnet_plugin")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        // Get data from dart
        val map: Map<String, Any?> = call.arguments as Map<String, Any?>

        val address = map.getOrDefault("address", "") as String
        val server = map.getOrDefault("server", "") as String
        val port = map.getOrDefault("port", -1) as Int
        val timeout = map.getOrDefault("timeout", -1) as Int
        // Note: Lỗi ở Ping, reset máy thử ( recommend: ko dùng AVD-Android Virtual Device (AndroidStudio-setting cực)
        when (call.method) {
            "getPingResult" -> result.success(
                LibrariesHandler(
                    "ping",
                    address = address
                ).getResult()
            )

            "getPageLoadResult" -> result.success(
                LibrariesHandler(
                    "pageLoad",
                    address = address
                ).getResult()
            )

            "getDnsLookupResult" -> result.success(
                LibrariesHandler(
                    "dnsLookup",
                    address = address,
                    server = server
                ).getResult()
            )

            "getPortScanResult" -> result.success(
                LibrariesHandler(
                    "portScan",
                    address = address,
                    port = port,
                    timeOut = timeout
                ).getResult()
            )

            else -> result.notImplemented()
        }
    }
}
