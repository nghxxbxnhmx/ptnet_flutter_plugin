import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ptnet_plugin/data.dart';
import 'package:ptnet_plugin/ptnet_plugin.dart';

class WifiScan extends StatefulWidget {
  final PtnetPlugin plugin;

  const WifiScan({super.key, required this.plugin});

  @override
  State<WifiScan> createState() => _WifiScanState();
}

class _WifiScanState extends State<WifiScan> {
  late PtnetPlugin _plugin;
  List<WifiScanResultDTO> _listWifi = [];
  Timer? _timer;
  static const int delayMillis = 30000;

  @override
  void initState() {
    super.initState();
    _plugin = widget.plugin;
    wifiScanHandle();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void wifiScanHandle() {
    wifiScanState();
    _timer =
        Timer.periodic(const Duration(milliseconds: delayMillis), (Timer t) {
      wifiScanState();
    });
  }

  Future<void> wifiScanState() async {
    try {
      // Get the Wi-Fi scan results
      List<WifiScanResultDTO>? scanResults = await _plugin.getWifiScanResult();
      setState(() {
        if (scanResults != null) {
          _listWifi = scanResults;
        }
      });
    } catch (e) {
      debugPrint("Failed to get Wi-Fi scan result: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wifi Home Page'),
      ),
      body: ListView.builder(
        itemCount: _listWifi.length,
        itemBuilder: (context, index) {
          final wifi = _listWifi[index];
          return Card(
            clipBehavior: Clip.hardEdge,
            color: (supportedWifi(wifi))
                ? Colors.green.withOpacity(0.6)
                : Colors.yellow.withOpacity(0.6),
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                // Handle the tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WifiDetailPage(wifi: wifi),
                  ),
                );
              },
              child: SizedBox(
                width: 300,
                height: 100,
                child: Center(
                  child: Text(
                    wifi.ssid,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool supportedWifi(WifiScanResultDTO wifi) {
    if (wifi.advancedInfo!.bss == 1) return true;
    if (wifi.advancedInfo!.ft == 1) return true;
    if (wifi.advancedInfo!.rm == 1) return true;
    if (wifi.advancedInfo!.ftm == 1) return true;
    if (wifi.advancedInfo!.pmf == 1) return true;
    if (wifi.advancedInfo!.mlo == 1) return true;

    return false;
  }
}

class WifiDetailPage extends StatelessWidget {
  final WifiScanResultDTO wifi;

  const WifiDetailPage({super.key, required this.wifi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WiFi Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('SSID', wifi.ssid),
              _buildDetailRow('BSSID', wifi.bssid),
              _buildDetailRow('Channel', wifi.channel.toString()),
              _buildDetailRow('Signal level', "${wifi.signalLevel}dBm"),
              _buildDetailRow('Bandwidth', "${wifi.channelBandwidth}MHz"),
              _buildDetailRow('Standard', wifi.advancedInfo!.standard),
              _buildDetailRow(
                  'Security Types', wifi.advancedInfo!.securityTypes),
              _buildDetailRow(
                  "Organization", wifi.advancedInfo!.manufacturer!.organization),
              _buildDetailRow(
                  "Address", wifi.advancedInfo!.manufacturer!.address),
              _buildDetailRow(
                  "Country", wifi.advancedInfo!.manufacturer!.countryCode),
              _buildDetailRow(
                  'BSS Transition', parseBT80211v(wifi.advancedInfo!.bss)),
              _buildDetailRow(
                  'Fast BSS Transition', parseFT80211r(wifi.advancedInfo!.ft)),
              _buildDetailRow(
                  'Radio Measurement', parseRM80211k(wifi.advancedInfo!.rm)),
              _buildDetailRow('Management Frame Protection',
                  parseMFP80211w(wifi.advancedInfo!.pmf)),
              _buildDetailRow('Fine-Timing Measurement',
                  parseFTM80211mc(wifi.advancedInfo!.ftm)),
              _buildDetailRow('Multi-link Operation',
                  parseMLO80211be(wifi.advancedInfo!.mlo)),
              _buildDetailRow(
                  'Multi-link Devices',
                  (wifi.advancedInfo!.mld.isNotEmpty)
                      ? wifi.advancedInfo!.mld
                      : "Not Supported"),
              // Add more rows for other fields
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String result) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(result),
        ],
      ),
    );
  }

  String parseBT80211v(int code) {
    return (code == -1) ? "?" : ((code == 1) ? "Supported" : "Not supported");
  }

  String parseFT80211r(int code) {
    return (code == -1) ? "?" : ((code == 1) ? "Supported" : "Not supported");
  }

  String parseRM80211k(int code) {
    return (code == -1)
        ? "Require API 33+"
        : ((code == 1) ? "Supported" : "Not supported");
  }

  String parseMFP80211w(int code) {
    return (code == -1)
        ? "Require API 33+"
        : ((code == 1) ? "Supported" : "Not supported");
  }

  String parseFTM80211mc(int code) {
    return (code == -1)
        ? "Require API 23+"
        : ((code == 1) ? "Supported" : "Not supported");
  }

  String parseMLO80211be(int code) {
    return (code == -1)
        ? "Require API 33+"
        : ((code == 1) ? "Supported" : "Not supported");
  }
}
