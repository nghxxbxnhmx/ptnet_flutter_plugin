package com.example.ptnet_plugin

import android.content.Context
import android.net.wifi.WifiManager
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
    private lateinit var context: Context
    private lateinit var wifiManager: WifiManager

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ptnet_plugin")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
        wifiManager =
            context.applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager

    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        // Get data from dart
        val map: Map<String, Any?> = call.arguments as Map<String, Any?>

        val ttl = map.getOrDefault("ttl", -1) as Int
        val port = map.getOrDefault("port", -1) as Int
        val timeout = map.getOrDefault("timeout", -1) as Int
        val server = map.getOrDefault("server", "") as String
        val address = map.getOrDefault("address", "") as String

        // Note: Lỗi ở Ping, reset máy thử ( recommend: ko dùng AVD-Android Virtual Device (AndroidStudio-setting cực)
        val librariesHandler = LibrariesHandler()
        when (call.method) {
            "getPingResult" -> result.success(
                librariesHandler.pingResult(address)
            )

            "getPageLoadResult" -> result.success(
                librariesHandler.pageLoadResult(address)
            )

            "getDnsLookupResult" -> result.success(
                librariesHandler.dnsLookUpResult(address, server)
            )

            "getPortScanResult" -> result.success(
                librariesHandler.portScanResult(address, port, timeout)
            )

            "getTraceRouteResult" -> result.success(
                librariesHandler.traceRouteResult(address, ttl)
            )

            "getTraceRouteEndpoint" -> result.success(
                librariesHandler.traceRouteEndpoint(address)
            )

            "getWifiScanResult" -> result.success(
                librariesHandler.wifiScanResult()
            )

            "getWifiInfo" -> result.success(
                librariesHandler.wifiInfo()
            )

            else -> result.notImplemented()
        }
    }
}
