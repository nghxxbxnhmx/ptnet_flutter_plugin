# Flutter App

This Flutter application utilizes the `ptnet_plugin` for network functionalities.

## Installation

1. Create a new Flutter app using the following command:
    ```bash
    flutter create app_name
    ```

2. Add the `ptnet_plugin` dependency to your `pubspec.yaml` file:
    ```yaml
    dependencies:
      ptnet_plugin:
        git:
          url: https://github.com/nghxxbxnhmx/ptnet_flutter_plugin
    ```

3. Ensure the required permissions are added to your `AndroidManifest.xml` file:
```xml
<!-- Wifi access permission -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CHANGE_WIFI_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.CHANGE_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
<uses-permission
        android:name="android.permission.BIND_VPN_SERVICE"
        tools:ignore="ProtectedPermissions" />
<application  android:usesCleartextTraffic="true"  .../>
```
## Kotlin Version

This project requires Kotlin version 1.9.0 or higher. To check your Kotlin version, run the following command in your project directory:
```bash
`kotlin -version` 
```
If your Kotlin version is not ***1.9.0 or higher***, you can update it by following the official Kotlin documentation: [Kotlin Installation Guide](https://kotlinlang.org/docs/getting-started.html#install-kotlin)


## Usage

### PTnet Flutter Library

This Flutter application uses the PTnet library to perform various network-related tasks. Below are the available functions and how to use them:

1. **getPingResult**
   - Description: Retrieves the ping result for a given host.
   - Usage:
     ```dart
     PingDTO pingResult = await PtnetPlugin().getPingResult(host);
     ```

2. **pageLoadResult**
   - Description: Loads a webpage and returns the result.
   - Usage:
     ```dart
     String pageResult = await PtnetPlugin().pageLoadResult(url);
     ```

3. **TraceRoute/Endpoint**
   - ***TraceRoute***: Performs a trace route with given host and ttl.
   - ***Endpoint***   : Find endpoint based on given host.
   - ***Description***: Declare endpoint -> TraceRoute loop until reach endpoints
   ```dart
   address = "zing.vn";
   TraceHopDTO endpoint = await _plugin.getTraceRouteEndpoint(address) ?? ...;
   int ttl = 1
   while(!reachEndpoint){
     TraceHopDTO traceResult = await _plugin.getTraceRouteResult(address,ttl) ?? ...
     traceList.add(traceResult)
     if(reachEndpoint){
       break;
     }
     -----------------
     ttl ++;
   }
   ```
   - ***Note***:  <u>Description</u>  just example, real will need to declare and write condition.

4. **DNSLookup**
   - Description: Performs a DNS lookup for the given domain and dns server.
   ```dart
   dnsResults = getDnsLookupResult("zing.vn", "8.8.8.8")
   ```

5. **WifiScan**
   - ***Description***: Scans for available Wi-Fi networks.
   - ***Note***: can use Timer for rescan Wifi.
   ```dart
       wifiScanState();
       _timer = Timer.periodic(const Duration(milliseconds: 30000 /*milliseconds*/),
        (Timer t) => wifiScanState());
   ```

6. **WifiInfo**
   - Description: Retrieves information about the connected Wi-Fi network.
   ```dart
      wifiInfoDTO = await _plugin.getWifiInfo()  ??  ...;
   ```

7. **PortScan**
   - Description: Scans for open ports on a given host, port, timeout (using loop)
   ```dart
      portScanDTO = getPortScanResult(host = "zing.vn",port =  1, timeout = 80 /*recommend*/)  ??  ...;
   ```

## License
