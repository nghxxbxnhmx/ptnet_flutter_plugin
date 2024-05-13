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
    return 'address: $address, ip: $ip, time: $time';
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
    return 'address: $address, port: $port, open: $open';
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
    return 'hopNumber: $hopNumber, domain: $domain, ipAddress: $ipAddress, time: $time, status: $status';
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
    return '$ssid (Channel $channel: $signalLevel dBm, $channelBandwidth Mhz)';
  }
}

class WifiInfoDTO {
  final String SSID;
  final String BSSID;
  final String gateWay;
  final String subnetMask;
  final String deviceMAC;
  final String ipAddress;

  WifiInfoDTO(
      {required this.SSID,
      required this.BSSID,
      required this.gateWay,
      required this.subnetMask,
      required this.deviceMAC,
      required this.ipAddress});

  factory WifiInfoDTO.fromJson(Map<String, dynamic> json) {
    return WifiInfoDTO(
        SSID: json['SSID'],
        BSSID: json['BSSID'],
        gateWay: json['gateWay'],
        subnetMask: json['subnetMask'],
        deviceMAC: json['deviceMAC'],
        ipAddress: json['ipAddress']);
  }

  @override
  String toString() {
    return 'SSID: $SSID, BSSID: $BSSID, gateWay: $gateWay, subnetMask: $subnetMask, deviceMAC: $deviceMAC, ipAddress: $ipAddress';
  }
}

// Useless - bỏ (1,2 biến trả về -> không cân thiết)
class PageLoadResult {}

class DnsResult {}
