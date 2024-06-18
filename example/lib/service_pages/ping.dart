import 'package:flutter/material.dart';
import 'package:ptnet_plugin/data.dart';
import 'package:ptnet_plugin/ptnet_plugin.dart';

class Ping extends StatefulWidget {
  final PtnetPlugin plugin;

  const Ping({Key? key, required this.plugin}) : super(key: key);

  @override
  State<Ping> createState() => _PingState();
}

class _PingState extends State<Ping> {
  late PtnetPlugin _plugin;
  final TextEditingController _controller = TextEditingController();

  PingDTO _pingResult = PingDTO(address: "", ip: "", time: -1.0);
  final PingDTO initPing = PingDTO(address: "", ip: "", time: -1.0);
  String _error = "";
  bool _isPinging = false;

  @override
  void initState() {
    super.initState();
    _plugin = widget.plugin;
  }

  String addressParser(String address) {
    return (address.isNotEmpty) ? address : "zing.vn";
  }

  void validateAddress(String input) {
    setState(() {
      final ipv4RegExp =
          RegExp(r'^([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.'
              r'([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.'
              r'([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.'
              r'([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$');
      if (ipv4RegExp.hasMatch(input)) {
        _error = "";
      } else {
        // Regular expression to validate domain name
        final domainRegExp = RegExp(r'^([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$');

        if (domainRegExp.hasMatch(input)) {
          _error = "";
        } else {
          setState(() {
            _error = "IP address/Hostname should be 1.1.1.1 or zing.vn";
          });
        }
      }
    });
  }

  String normalizeURL(String input) {
    // Regular expression to match any whitespace around dots
    final regex = RegExp(r'\s*\.\s*');

    // Replace all occurrences with a single dot
    String normalized = input.replaceAll(regex, '.');

    // Trim any leading or trailing whitespace
    normalized = normalized.trim();

    return normalized;
  }

  Future<void> _executePing(String ipAddress) async {
    if (_error.isEmpty) {
      setState(() { _isPinging = true; });
      try {
        PingDTO pingResult = await _plugin.getPingResult(ipAddress) ?? initPing;
        setState(() {
          if (pingResult == initPing) {
            _error = "Can not reach ip/hostname: $ipAddress";
          }
          _pingResult = pingResult;
        });
      } catch (e) {
        setState(() {
          _error = '$e';
        });
      } finally {
        setState(() {
          _isPinging = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ping Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _controller,
              enabled: !_isPinging,
              decoration: const InputDecoration(
                labelText: 'Enter IP Address or Hostname',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _isPinging
                  ? null
                  : () {
                      String ipAddress =
                          normalizeURL(addressParser(_controller.text));
                      validateAddress(ipAddress);
                      _controller.text = ipAddress;
                      if (ipAddress.isNotEmpty && _error.isEmpty) {
                        _executePing(ipAddress);
                      } else {
                        setState(() {
                          _error = 'Invalid IP Address or Hostname';
                        });
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isPinging ? Colors.grey : Colors.blue, // Change color when pinging
              ),
              child: const Text('Ping'),
            ),
            const SizedBox(height: 20.0),
            _isPinging
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _error.isEmpty
                    ? Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow('Address', _pingResult.address),
                            _buildDetailRow('IP', _pingResult.ip),
                            _buildDetailRow('Time', '${_pingResult.time}ms'),
                            if (_error.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  _error,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          _error,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
          ],
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
}
