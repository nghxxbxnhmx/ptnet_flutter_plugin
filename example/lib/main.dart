import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:ptnet_plugin/data.dart';
import 'package:ptnet_plugin/permission.dart';
import 'package:ptnet_plugin/ptnet_plugin.dart';
import 'package:ptnet_plugin_example/widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _result = '';
  final _plugin = PtnetPlugin();

  // Controller - UI
  final inputServer = TextEditingController();
  final inputAddress = TextEditingController();

  // TTL - Port - Server - Address - Progress - Execute
  var visibleUI = [false, false, false, false, false, true];
  var editEnable = false;
  var executeEnable = false;

  var height = [4,8,4,4,8,8,4];

  // Realtime - update
  Timer? _timer;
  static const int delayMillis = 30000; // Change the delay as needed

  // Unchanged Values
  final _initAddress = 'zing.vn';
  final String _dnsServer = "8.8.8.8";

  // Changed Values
  String actionValue = 'Ping';
  var actionValues = [
    'Ping',
    'PageLoad',
    'DnsLookup',
    'PortScan',
    'TraceRoute',
    'WifiScan',
    'WifiInfo'
  ];
  final ValueNotifier<int?> selectedTTL = ValueNotifier<int?>(null);
  final ValueNotifier<int?> selectedPortType = ValueNotifier<int?>(null);

  @override
  void dispose() {
    _timer?.cancel();
    selectedTTL.dispose(); // Don't forget to dispose of the ValueNotifier
    selectedPortType.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    PermissionResquest().requestPermission();
    initAction();
  }

  void initValue() {
    _result = "";
    visibleUI.fillRange(
        0, 6, false); // Initialize all elements of visibleUI to false
    visibleUI[3] = true; // Address
    visibleUI[5] = true; // Execute
    executeEnable = true;
    selectedTTL.value = 1;
    selectedPortType.value = 0;
    inputAddress.text = _initAddress;
  }

  void initAction() {
    _timer?.cancel();
    initValue();
    switch (actionValue) {
      case "DnsLookup":
        visibleUI[2] = true;
        inputServer.text = "8.8.8.8";
        break;
      case "PortScan":
        visibleUI[0] = true; // TTL
        visibleUI[1] = true; // Port
        break;
      case "WifiScan":
        visibleUI[3] = false;
        visibleUI[5] = false;
        break;
      case "WifiInfo":
        visibleUI[3] = false;
        break;
      default:
        break;
    }
  }

  // Act use by Execute
  void callState(String act) {
    Map<String, Function> stateFunctions = {
      "Ping": pingState,
      "PageLoad": pageLoadState,
      "DnsLookup": dnsLookupState,
      "TraceRoute": traceRouteState,
      "PortScan": portScanState,
      "WifiInfo": wifiInfoState,
    };

    stateFunctions[act]?.call();
  }

  // UI processor
  void executeHandle(bool status) {
    setState(() {
      executeEnable = status;
    });
  }

  void editableHandle(bool status) {
    setState(() {
      editEnable = status;
    });
  }

  void resultHandle(String result) {
    setState(() {
      _result = result;
    });
  }

  void setInputAddress(String address) {
    inputAddress.text = address;
  }

  String getInputAddress() {
    return (inputAddress.text.isNotEmpty) ? inputAddress.text : _initAddress;
  }

  void setInputServer(String server) {
    inputServer.text = server;
  }

  String getInputServer() {
    return (inputServer.text.isNotEmpty) ? inputServer.text : _dnsServer;
  }

  void visibleControl(int index, bool status) {
    setState(() {
      visibleUI[index] = status;
    });
  }

  Future<void> pingState() async {
    String error = "";
    String address = getInputAddress();
    PingDTO pingResult = PingDTO(address: "", ip: "", time: -1.0);
    // Start process  -------------------------------------------
    resultHandle("");
    executeHandle(false);
    setInputAddress(address);

    // Execute
    try {
      pingResult = await _plugin.getPingResult(address) ?? pingResult;
    } on Exception catch (e) {
      error = e.toString();
    }

    // End process   -------------------------------------------
    if (!mounted) return;
    if (pingResult.time != -1) {
      resultHandle("\n${pingResult.toString()}");
    } else {
      resultHandle('\nFailed to get ping result');
    }
    executeHandle(true);
  }

  Future<void> pageLoadState() async {
    int time = 10;
    String pageLoadResult = "";
    String address = getInputAddress();
    // Start process  -------------------------------------------
    resultHandle("");
    executeHandle(false);
    editableHandle(false);
    setInputAddress(address);

    // Execute
    while (time > 0) {
      if (executeEnable) {
        break;
      } else {
        try {
          pageLoadResult = await _plugin.getPageLoadResult(address) ?? "";
        } on Exception catch (e) {
          pageLoadResult = "Fail to get page load result";
        }

        resultHandle("$_result\nTime: $pageLoadResult ms");
        time--;
      }
    }

    // End process   -------------------------------------------
    if (!mounted) return;
    executeHandle(true);
    editableHandle(true);
  }

  Future<void> dnsLookupState() async {
    String error = "";
    List<String> dnsLookupResult = [];
    String address = getInputAddress();
    String server = getInputServer();
    // Start process  -------------------------------------------
    resultHandle("");
    setInputAddress(address);
    setInputServer(server);
    executeHandle(false);

    // Execute
    try {
      dnsLookupResult = await _plugin.getDnsLookupResult(address, server) ?? [];
    } on Exception {
      error = "Fail to get page load result";
    }

    // End process   -------------------------------------------
    if (!mounted) return;
    if (error.isNotEmpty) {
      resultHandle(error);
    } else {
      for (var element in dnsLookupResult) {
        resultHandle("$_result\n$element");
      }
      executeHandle(true);
    }
  }

  int _currentPort = 0;
  int _endPort = 0;
  int _rootPort = 0;

  void selectedPortRange() {
    int portType = int.tryParse(selectedPortType.value.toString()) ?? 1;
    switch (portType) {
      case 0:
        _currentPort = 1;
        _endPort = 1023;
        break;
      case 1:
        _currentPort = 1024;
        _endPort = 49151;
        break;
      case 2:
        _currentPort = 49152;
        _endPort = 65565;
        break;
      default:
        _currentPort = 1;
        _endPort = 65565;
        break;
    }
    _rootPort = _currentPort;
  }

  Future<void> portScanState() async {
    String error = "";
    String address = getInputAddress();
    int timeout = int.tryParse(selectedTTL.value.toString()) ?? 1;
    PortDTO portDTO = PortDTO(address: "", port: -1, open: false);
    selectedPortRange();
    // Start process  -------------------------------------------
    resultHandle("");
    executeHandle(false);
    visibleControl(4, true);
    setInputAddress(address);

    // Execute
    for (var port = _rootPort; port <= _endPort; port++) {
      portDTO = PortDTO(address: "", port: -1, open: false);
      if (!executeEnable) {
        try {
          portDTO = await _plugin.getPortScanResult(address, port, timeout) ??
              portDTO;
          if (portDTO.port != -1 && portDTO.open) {
            resultHandle("$_result\n$portDTO");
          }
        } on Exception {
          error = "Fail to get port scan result";
        }
        setState(() {
          _currentPort = port;
        });
      }
    }

    // End process   -------------------------------------------
    if (!mounted) return;
    if (error.isNotEmpty) {
      resultHandle("\n$error");
    } else {
      executeHandle(true);
      if (_currentPort == _endPort) {
        visibleControl(4, false);
      }
    }
  }

  Future<void> traceRouteState() async {
    String error = "";
    String address = getInputAddress();
    List<TraceHopDTO> traceList = [];
    var hop1 = TraceHopDTO(
        hopNumber: 0, domain: "", ipAddress: "", time: -1, status: false);
    var hop2 = TraceHopDTO(
        hopNumber: 0, domain: "", ipAddress: "", time: -1, status: false);
    var traceResult = TraceHopDTO(
        hopNumber: 0, domain: "", ipAddress: "", time: -1, status: false);
    var endpoint = TraceHopDTO(
        hopNumber: 0, domain: "", ipAddress: "", time: -1, status: false);
    // Start process  -------------------------------------------
    resultHandle("");
    executeHandle(false);
    setInputAddress(address);

    // Execute
    try {
      endpoint = await _plugin.getTraceRouteEndpoint(address) ?? endpoint;
    } on Exception {
      error = "Fail to get endpoint";
    }

    var ttl = 1;
    while (traceResult.ipAddress != endpoint.ipAddress || ttl <= 255) {
      traceResult = TraceHopDTO(
          hopNumber: 0, domain: "", ipAddress: "", time: -1, status: false);
      // Stop / Run
      if (!executeEnable) {
        try {
          traceResult =
              await _plugin.getTraceRouteResult(address, ttl) ?? traceResult;
          if (traceResult.hopNumber != 0) {
            traceList.add(traceResult);
          }
        } on Exception {
          error = "Fail to get trace route result";
        }

        if (error.isEmpty) {
          resultHandle("$_result\n${traceResult.toString()}");
        } else {
          resultHandle("$_result\nRequest timeout!!!");
        }

        if (traceList.length == 2) {
          hop1 = traceList[0];
          hop2 = traceList[1];
        }
        if (traceList.length > 2) {
          hop1 = traceList[traceList.length - 2];
          hop2 = traceList[traceList.length - 1];
        }

        if (traceResult.ipAddress == endpoint.ipAddress) {
          break;
        } else {
          if (hop1.ipAddress == hop2.ipAddress && hop1.ipAddress.isNotEmpty) {
            break;
          }
        }

        ttl++;
      } else {
        break;
      }
    }

    // End process   -------------------------------------------
    if (!mounted) return;
    executeHandle(true);
  }

  void wifiScanHandle() {
    wifiScanState();
    _timer = Timer.periodic(const Duration(milliseconds: delayMillis),
        (Timer t) => wifiScanState());
  }

  Future<void> wifiScanState() async {
    String error = "";
    List<WifiScanResultDTO> scanResult = [];

    // Start process
    resultHandle(_result);

    // Execute
    if (actionValue == 'WifiScan') {
      // Attempt to rescan Wi-Fi networks
      try {
        // Get the Wi-Fi scan results
        scanResult = await _plugin.getWifiScanResult() ?? scanResult;
      } catch (e) {
        error = "Failed to get Wi-Fi scan result: $e"; // Update error message
      }
    } else {
      _timer?.cancel();
    }

    // End process   -------------------------------------------
    if (!mounted) return;
    if (scanResult.isNotEmpty) {
      _result = "";
      for (var element in scanResult) {
        resultHandle("$_result\n${element.toString()}");
      }
    } else {
      _result = _result;
    }
  }

  Future<void> wifiInfoState() async {
    String error = "";
    WifiInfoDTO wifiInfo = WifiInfoDTO(
        SSID: "",
        BSSID: "",
        gateWay: "",
        subnetMask: "",
        deviceMAC: "",
        ipAddress: "");
    // Start process  -------------------------------------------
    resultHandle("");
    executeHandle(false);

    // Execute
    try {
      wifiInfo = await _plugin.getWifiInfo() ?? wifiInfo;
    } on Exception {
      error = "Fail to get wifi info";
    }

    // End process   -------------------------------------------
    if (!mounted) return;
    executeHandle(true);
    if (error.isNotEmpty) {
      resultHandle("\n$error");
    } else {
      resultHandle("\n${wifiInfo.toString()}");
    }
  }

  void onChanged(String? newValue) {
    setState(() {
      actionValue =
          newValue!; // Update the actionValue variable with the newly selected value
      // Call any other methods or update any other variables as needed
      initAction(); // Example: Call initAction method
      switch (actionValue) {
        case "WifiScan":
          wifiScanHandle();
          break;
        default:
          break;
      }
    });
  }

  void stopExecute(String? p1) {
    setState(() {
      executeEnable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          // child: Text('Running on: $_platformVersion\n'),
          child: Column(
            children: [
              CustomDropdownButton(
                enabled: executeEnable,
                actionValue: actionValue,
                actionValues: actionValues,
                onChanged: onChanged,
              ),
              IpForm(
                  controller: inputAddress,
                  enabled: executeEnable,
                  visible: visibleUI[3]),
              DNSServerForm(
                  visible: visibleUI[2],
                  enabled: executeEnable,
                  inputServer: inputServer),
              PortRangeForm(
                  visible: visibleUI[1],
                  enabled: executeEnable,
                  selectedPortType: selectedPortType),
              TimeOutForm(
                visible: visibleUI[0],
                enabled: executeEnable,
                selectedValue: selectedTTL,
              ),
              const SizedBox(height: 30),
              ExecuteButton(
                  visible: visibleUI[5],
                  enabled: executeEnable,
                  actionValue: actionValue,
                  onPressed: callState,
                  stopPressed: stopExecute),
              const SizedBox(height: 12),
              CustomResultWidget(
                visible: visibleUI[4],
                currentPort: _currentPort - _rootPort + 1,
                endPort: _endPort - _rootPort + 1,
                actionValue: actionValue,
                result: _result,
                resultHeight: height[actionValues.indexOf(actionValue)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
