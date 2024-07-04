class PingDTO {
  final String address;
  final String ip;
  final double time;

  PingDTO({required this.address, required this.ip, required this.time});

  factory PingDTO.fromJson(Map<String, dynamic> json) {
    return PingDTO(
      address: json['address'],
      ip: json['ip'],
      time: double.parse(json['time']
          .toString()
          .substring(0, json['time'].toString().indexOf('.') + 3)),
    );
  }

  @override
  String toString() {
    return 'PingDTO{address: $address, ip: $ip, time: $time}';
  }
}

class PortDTO {
  final String address;
  final int port;
  final bool open;

  PortDTO({required this.address, required this.port, required this.open});

  factory PortDTO.fromJson(Map<String, dynamic> json) {
    return PortDTO(
        address: json['address'],
        port: json['port'],
        open: bool.parse(json['open'].toString()));
  }

  @override
  String toString() {
    return 'PortDTO{address: $address, port: $port, open: $open}';
  }
}

class TraceHopDTO {
  final int hopNumber;
  final String domain;
  final String ipAddress;
  final double time;
  final bool status;

  TraceHopDTO(
      {required this.hopNumber,
      required this.domain,
      required this.ipAddress,
      required this.time,
      required this.status});

  factory TraceHopDTO.fromJson(Map<String, dynamic> json) {
    return TraceHopDTO(
        hopNumber: int.parse(json['hopNumber'].toString()),
        domain: json['domain'],
        ipAddress: json['ipAddress'],
        time: double.parse(json['time'].toString()),
        status: bool.parse(json['status'].toString()));
  }

  @override
  String toString() {
    return 'TraceHopDTO{hopNumber: $hopNumber, domain: $domain, ipAddress: $ipAddress, time: $time, status: $status}';
  }
}

class WifiScanResultDTO {
  final String ssid;
  final String bssid;
  final int channel;
  final int signalLevel;
  final int channelBandwidth;

  WifiScanResultDTO(
      {required this.ssid,
      required this.bssid,
      required this.channel,
      required this.signalLevel,
      required this.channelBandwidth});

  factory WifiScanResultDTO.fromJson(Map<String, dynamic> json) {
    return WifiScanResultDTO(
        ssid: json['ssid'],
        bssid: json['bssid'],
        channel: int.parse(json['channel'].toString()),
        signalLevel: int.parse(json['signalLevel'].toString()),
        channelBandwidth: int.parse(json['channelBandwidth'].toString()));
  }

  @override
  String toString() {
    return 'WifiScanResultDTO{ssid: $ssid, bssid: $bssid, channel: $channel, signalLevel: $signalLevel, channelBandwidth: $channelBandwidth}';
  }
}

class WifiInfoDTO {
  final String ssid;
  final String bssid;
  final String gateway;
  final String subnetMask;
  final String deviceMAC;
  final String ipAddress;
  final String externalIpAddress;

  WifiInfoDTO(
      {required this.ssid,
      required this.bssid,
      required this.gateway,
      required this.subnetMask,
      required this.deviceMAC,
      required this.ipAddress,
      required this.externalIpAddress});

  factory WifiInfoDTO.fromJson(Map<String, dynamic> json) {
    return WifiInfoDTO(
        ssid: json['ssid'],
        bssid: json['bssid'],
        gateway: json['gateway'],
        subnetMask: json['subnetMask'],
        deviceMAC: json['deviceMAC'],
        ipAddress: json['ipAddress'],
        externalIpAddress: json['externalIpAddress']);
  }

  @override
  String toString() {
    return 'WifiInfoDTO{ssid: $ssid, bssid: $bssid, gateway: $gateway, subnetMask: $subnetMask, deviceMAC: $deviceMAC, ipAddress: $ipAddress, externalIPAddress: $externalIpAddress}';
  }
}

class PageLoadDTO {
  final String data;
  final String status;
  final int statusCode;
  final double responseTime;
  final String message;

  PageLoadDTO(
      {required this.data,
      required this.status,
      required this.statusCode,
      required this.responseTime,
      required this.message});

  factory PageLoadDTO.fromJson(Map<String, dynamic> json) {
    return PageLoadDTO(
        data: json['data'],
        status: json['status'],
        statusCode: int.parse(json['statusCode'].toString()),
        responseTime: double.parse(json['responseTime'].toString()),
        message: json['message']);
  }

  @override
  String toString() {
    return 'PageLoadDTO{data: $data, status: $status, statusCode: $statusCode, responseTime: $responseTime, message: $message}';
  }
}
