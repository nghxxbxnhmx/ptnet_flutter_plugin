import 'dart:convert';

import 'package:flutter/cupertino.dart';

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

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'ip': ip,
      'time': time.toString(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'port': port,
      'open': open,
    };
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
}

class WifiScanResultDTO {
  final String ssid;
  final String bssid;
  final List<int> channel;
  final int signalLevel;
  final int channelBandwidth;
  final AdvancedInfo? advancedInfo;

  WifiScanResultDTO({
    required this.ssid,
    required this.bssid,
    required this.channel,
    required this.signalLevel,
    required this.channelBandwidth,
    required this.advancedInfo,
  });

  factory WifiScanResultDTO.fromJson(Map<String, dynamic> json) {
    return WifiScanResultDTO(
      ssid: json['ssid'],
      bssid: json['bssid'],
      channel: List<int>.from(json['channel'] ?? []),
      signalLevel: json['signalLevel'] ?? 0,
      channelBandwidth: json['channelBandwidth'] ?? 0,
      advancedInfo: json['advancedInfo'] != null
          ? AdvancedInfo.fromJson(json['advancedInfo'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ssid": ssid,
      "bssid": bssid,
      "channel": channel,
      "signalLevel": signalLevel,
      "channelBandwidth": channelBandwidth,
      "advancedInfo": advancedInfo?.toJson(),
    };
  }
}

class AdvancedInfo {
  final String standard;
  final String capabilities;
  final Manufacturer? manufacturer;
  final String securityTypes;
  final int bss;
  final int ft;
  final int rm;
  final int ftm;
  final int mlo;
  final String mld;
  final int pmf;

  AdvancedInfo({
    required this.standard,
    required this.capabilities,
    required this.manufacturer,
    required this.securityTypes,
    required this.bss,
    required this.ft,
    required this.rm,
    required this.ftm,
    required this.pmf,
    required this.mlo,
    required this.mld,
  });

  factory AdvancedInfo.fromJson(Map<String, dynamic> json) {
    return AdvancedInfo(
      standard: json['standard'] ?? '',
      capabilities: json['capabilities'],
      manufacturer: json['manufacturer'].toString().isNotEmpty
          ? Manufacturer.fromJson(json['manufacturer'])
          : null,
      securityTypes: json['securityTypes'] ?? '',
      bss: json['bss'] ?? 0,
      ft: json['ft'] ?? 0,
      rm: json['rm'] ?? 0,
      ftm: json['ftm'] ?? 0,
      pmf: json['pmf'] ?? 0,
      mlo: json['mlo'] ?? 0,
      mld: json['mld'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "standard": standard,
      "capabilities": capabilities,
      "securityTypes": securityTypes,
      "manufacturer": manufacturer?.toJson(),
      "bss": bss,
      "ft": ft,
      "rm": rm,
      "pmf": pmf,
      "ftm": ftm,
      "mlo": mlo,
      "mld": mld,
    };
  }
}

class Manufacturer {
  final String hex;
  final String base16;
  final String organization;
  final String address;
  final String postcode;
  final String countryCode;

  Manufacturer({
    required this.hex,
    required this.base16,
    required this.organization,
    required this.address,
    required this.postcode,
    required this.countryCode,
  });

  factory Manufacturer.fromJson(Map<String, dynamic> json) {
    return Manufacturer(
      hex: json['hex'].toString() ?? '',
      base16: json['base16'].toString() ?? '',
      organization: json['organization'].toString() ?? '',
      address: json['address'].toString() ?? '',
      postcode: json['postcode'].toString() ?? '',
      countryCode: json['countryCode'].toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "hex": hex,
      "base16": base16,
      "organization": organization,
      "address": address,
      "postcode": postcode,
      "countryCode": countryCode,
    };
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
}

// Useless - bỏ (1,2 biến trả về -> không cân thiết)
// class PageLoadResult {}
// class DnsResult {}
