import 'package:flutter/material.dart';
import 'package:ptnet_plugin/permission.dart';
import 'package:ptnet_plugin/ptnet_plugin.dart';
import 'package:ptnet_plugin_example/service_pages/all.dart';

class HomePage extends StatelessWidget {
  final PtnetPlugin plugin;

  const HomePage({super.key, required this.plugin});

  @override
  Widget build(BuildContext context) {
    PermissionResquest().requestPermission();
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
            left: 10.0, top: 50.0, bottom: 15.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20.0),
              child: const Text(
                'PTnet Flutter',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10.0),
            // Ping Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Ping(plugin: plugin)),
                );
              },
              icon: const Icon(Icons.network_check),
              label: const Text('Ping'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                textStyle: const TextStyle(fontSize: 18.0),
              ),
            ),

            const SizedBox(height: 10.0),
            // PageLoad Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PageLoad(plugin: plugin)),
                );
              },
              icon: const Icon(Icons.web),
              label: const Text('Page Load'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                textStyle: const TextStyle(fontSize: 18.0),
              ),
            ),

            const SizedBox(height: 10.0),
            // TraceRoute Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TraceRoute(plugin: plugin)),
                );
              },
              icon: const Icon(Icons.timeline),
              label: const Text('Trace Route'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                textStyle: const TextStyle(fontSize: 18.0),
              ),
            ),

            const SizedBox(height: 10.0),
            // PortScan Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PortScan(plugin: plugin)),
                );
              },
              icon: const Icon(Icons.settings_ethernet),
              label: const Text('Port Scan'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                textStyle: const TextStyle(fontSize: 18.0),
              ),
            ),

            const SizedBox(height: 10.0),
            // DNSLookup Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DNSLookup(plugin: plugin)),
                );
              },
              icon: const Icon(Icons.dns),
              label: const Text('DNS Lookup'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                textStyle: const TextStyle(fontSize: 18.0),
              ),
            ),

            const SizedBox(height: 10.0),
            // Wifi Scan
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WifiScan(plugin: plugin)),
                );
              },
              icon: const Icon(Icons.wifi),
              label: const Text('Wifi Scan'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                textStyle: const TextStyle(fontSize: 18.0),
              ),
            ),

            const SizedBox(height: 10.0),
            // WifiInfo Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WifiInfo(plugin: plugin)),
                );
              },
              icon: const Icon(Icons.info),
              label: const Text('Wifi Info'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                textStyle: const TextStyle(fontSize: 18.0),
              ),
            ),
            const SizedBox(height: 10.0),
            // Add more buttons here as needed
          ],
        ),
      ),
    );
  }
}
