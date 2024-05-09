import 'package:flutter/material.dart';
import 'dart:async';

import 'package:ptnet_plugin/data.dart';
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
  final _ptnetPlugin = PtnetPlugin();

  // Controller - UI
  final inputServer = TextEditingController();
  final inputAddress = TextEditingController();
  var visibleTTL = false;
  var visibleServer = false;
  var visiblePort = false;
  var visibleProgress = false;
  var executeEnable = false;
  var editEnable = false;
  var timeLabel = false;

  // Unchanged Values
  final int _initTTL = -1;
  final _initAddress = 'zing.vn';

  final String _dnsServer = "8.8.8.8";

  // Changed Values
  String actionValue = 'Ping';
  var actionValues = [
    'Ping',
    'PageLoad',
    'DnsLookup',
    'PortScan',
    'TraceRoute'
  ];
  final ValueNotifier<int?> selectedTTL = ValueNotifier<int?>(null);
  final ValueNotifier<int?> selectedPortType = ValueNotifier<int?>(null);

  @override
  void dispose() {
    selectedTTL.dispose(); // Don't forget to dispose of the ValueNotifier
    selectedPortType.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initInput();
  }

  void initInput() {
    inputAddress.text = _initAddress;
    _result = "";
    executeEnable = true;
    selectedTTL.value = 1;
    selectedPortType.value = 0;
    setState(() {
      visibleTTL = false;
      visiblePort = false;
      visibleServer = false;
      visibleProgress = false;
      switch (actionValue) {
        case "DnsLookup":
          visibleServer = true;
          break;
        case "PortScan":
          visibleTTL = true;
          visiblePort = true;
          timeLabel = false;
          break;
        case "TraceRoute":
          visibleTTL = true;
          timeLabel = true;
          break;
        default:
          break;
      }
    });
  }

  Future<void> pingState() async {
    // Start process  -------------------------------------------
    setState(() {
      executeEnable = false;
    });

    PingDTO pingResult = PingDTO(address: "", ip: "", time: -1.0);
    String error = "";
    String address =
        (inputAddress.text.isNotEmpty) ? inputAddress.text : _initAddress;

    // Execute
    try {
      // pingResult = await _ptnetPlugin.getPingResult(address) ??
      //     'Invalid Ping Result';
      pingResult = await _ptnetPlugin.getPingResult(address) ??
          PingDTO(address: "", ip: "", time: -1.0);
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    // End process   -------------------------------------------
    setState(() {
      if (pingResult.time == -1.0) {
        _result = 'Failed to get ping result.';
      } else {
        _result = "$pingResult";
      }
      executeEnable = true;
    });
  }

  Future<void> pageLoadState() async {
    String address =
        (inputAddress.text.isNotEmpty) ? inputAddress.text : _initAddress;
    PageLoadDTO pageLoadResult = PageLoadDTO(address: "", time: -1.0);

    int time = 10;
    String error = "";
    // Start process  -------------------------------------------
    setState(() {
      _result = "";
      editEnable = false;
      executeEnable = false;
      inputAddress.text = address;
    });
    // Execute
    while (time > 0) {
      if (executeEnable) {
        break;
      } else {
        try {
          pageLoadResult = await _ptnetPlugin.getPageLoadResult(address) ??
              PageLoadDTO(address: "", time: -1.0);
        } on Exception catch (e) {
          error = "Fail to get page load result";
        }

        setState(() {
          _result += "$pageLoadResult\n";
        });
        time--;
      }
    }

    // End process   -------------------------------------------
    if (!mounted) return;
    setState(() {
      executeEnable = true;
      editEnable = true;
    });
  }

  Future<void> dnsLookupState() async {
    List<AnswerDTO> dnsLookupResult = [];
    String address =
        (inputAddress.text.isNotEmpty) ? inputAddress.text : _initAddress;
    String server =
        (inputServer.text.isNotEmpty) ? inputServer.text : _initAddress;
    String error = "";
    // Start process  -------------------------------------------
    setState(() {
      _result = "";
      executeEnable = false;
      inputAddress.text = address;
      inputServer.text = server;
    });
    // Execute
    try {
      dnsLookupResult =
          await _ptnetPlugin.getDnsLookupResult(address, server) ?? [];
    } on Exception {
      error = "Fail to get page load result";
    }

    if (!mounted) return;
    // End process   -------------------------------------------
    setState(() {
      for (var element in dnsLookupResult) {
        _result += "$element\n";
      }
      executeEnable = true;
    });
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
    String address =
        (inputAddress.text.isNotEmpty) ? inputAddress.text : _initAddress;
    int timeout = int.tryParse(selectedTTL.value.toString()) ?? 1;
    selectedPortRange();

    String error = "";
    // Start process  -------------------------------------------
    setState(() {
      _result = "";
      executeEnable = false;
      visibleProgress = true;
      inputAddress.text = address;
    });
    // Execute
    for (var port = _rootPort; port <= _endPort; port++) {
      if (!executeEnable) {
        try {
          PortDTO portDTO =
              await _ptnetPlugin.getPortScanResult(address, port, timeout) ??
                  PortDTO(address: "", port: -1, open: false);
          setState(() {
            if (portDTO.port != -1 && portDTO.open) {
              _result += "$portDTO\n";
            }
            _currentPort = port;
          });
        } on Exception {
          error = "Fail to get port scan result";
        }
      }
    }

    // End process   -------------------------------------------
    if (!mounted) return;
    setState(() {
      executeEnable = true;
      if (_currentPort == _endPort) {
        visibleProgress = false;
      }
    });
  }

  Future<void> traceRouteState() async {
    // Start process  -------------------------------------------
    setState(() {
      _result = "";
      executeEnable = false;
    });
    // Execute

    // End process   -------------------------------------------
    if (!mounted) return;
    setState(() {
      _result = "Traceroute Result nek";
      executeEnable = true;
    });
  }

  void callState(String act) {
    switch (act) {
      case "Ping":
        pingState();
        break;
      case "PageLoad":
        pageLoadState();
        break;
      case "DnsLookup":
        dnsLookupState();
      case "TraceRoute":
        traceRouteState();
        break;
      case "PortScan":
        portScanState();
        break;
      default:
        break;
    }
  }

  void onChanged(String? newValue) {
    setState(() {
      actionValue =
          newValue!; // Update the actionValue variable with the newly selected value
      // Call any other methods or update any other variables as needed
      initInput(); // Example: Call initInput method
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
              IpForm(controller: inputAddress, enabled: executeEnable),
              DNSServerForm(
                  visible: visibleServer,
                  enabled: executeEnable,
                  inputServer: inputServer),
              PortRangeForm(
                  visible: visiblePort,
                  enabled: executeEnable,
                  selectedPortType: selectedPortType),
              TTLForm(
                visible: visibleTTL,
                enabled: executeEnable,
                label: timeLabel,
                selectedValue: selectedTTL,
              ),
              const SizedBox(height: 30),
              ExecuteButton(
                  enabled: executeEnable,
                  actionValue: actionValue,
                  onPressed: callState,
                  stopPressed: stopExecute),
              const SizedBox(height: 12),
              CustomResultWidget(
                visibleProgress: visibleProgress,
                currentPort: _currentPort - _rootPort + 1,
                endPort: _endPort - _rootPort + 1,
                actionValue: actionValue,
                result: _result,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
