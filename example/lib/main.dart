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
  final inputTTL = TextEditingController();
  final inputServer = TextEditingController();
  final inputAddress = TextEditingController();
  final inputPortEnd = TextEditingController();
  final inputPortStart = TextEditingController();
  var enableTTL = false;
  var visibleTTL = false;
  var enableServer = false;
  var visibleServer = false;
  var enablePort = false;
  var visiblePort = false;
  var visibleProgress = false;
  var executeEnable = true;
  var editEnable = true;

  // Unchanged Values
  final int _initTTL = -1;
  final _initAddress = 'zing.vn';
  final int _startPort = 1;
  final String _dnsServer = "8.8.8.8";

  // Changed Values
  int _currentPort = 1;
  int _endPort = 1023;

  // DropdownList
  String actionValue = 'Ping';
  var actionValues = [
    'Ping',
    'PageLoad',
    'DnsLookup',
    'PortScan',
    'TraceRoute'
  ];

  @override
  void initState() {
    super.initState();
    initInput();
  }

  void initInput() {
    inputAddress.text = _initAddress;
    _result = "";
    executeEnable = true;
    setState(() {
      switch (actionValue) {
        case "TraceRoute":
          enableTTL = true;
          visibleTTL = true;
          enableServer = false;
          visibleServer = false;
          enablePort = false;
          visiblePort = false;
          visibleProgress = false;
          inputTTL.text = "$_initTTL";
          break;
        case "DnsLookup":
          enableTTL = false;
          visibleTTL = false;
          enableServer = true;
          visibleServer = true;
          enablePort = false;
          visiblePort = false;
          visibleProgress = false;
          inputServer.text = "$_dnsServer";
          break;
        case "PortScan":
          enableTTL = false;
          visibleTTL = false;
          enableServer = false;
          visibleServer = false;
          enablePort = true;
          visiblePort = true;
          visibleProgress = false;
          inputPortStart.text = "$_startPort";
          inputPortEnd.text = "$_endPort";
          break;
        default:
          enableTTL = false;
          visibleTTL = false;
          enableServer = false;
          visibleServer = false;
          enablePort = false;
          visiblePort = false;
          visibleProgress = false;
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
                executeEnable: executeEnable,
                actionValue: actionValue,
                actionValues: actionValues,
                onChanged: onChanged,
              ),
              IpForm(controller: inputAddress),
              TTLForm(
                  visible: visibleTTL,
                  enabled: enableTTL,
                  controller: inputTTL),
              DNSServerForm(
                  visible: visibleServer,
                  enabled: enableServer,
                  inputServer: inputServer),
              PortRangeForm(
                  visible: visiblePort,
                  enabled: enablePort,
                  editEnable: editEnable,
                  inputPortStart: inputPortStart,
                  inputPortEnd: inputPortEnd),
              const SizedBox(height: 30),
              ExecuteButton(
                  executeEnable: executeEnable,
                  actionValue: actionValue,
                  onPressed: callState,
                  stopPressed: stopExecute),
              const SizedBox(height: 12),
              CustomResultWidget(
                visibleProgress: visibleProgress,
                currentPort: _currentPort,
                endPort: _endPort,
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
