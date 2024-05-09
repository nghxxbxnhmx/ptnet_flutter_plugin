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

class PageLoadDTO {
  final String address;
  final double time;

  PageLoadDTO({required this.address, required this.time});

  factory PageLoadDTO.fromJson(Map<String, dynamic> json) {
    return PageLoadDTO(
      address: json['address'],
      time: double.parse(json['time'].toString()),
    );
  }

  @override
  String toString() {
    return 'PageLoadDTO{address: $address, time: $time}';
  }
}

class AnswerDTO {
  final String name;
  final String data;
  final int type;
  final int ttl;

  AnswerDTO(
      {required this.name, required this.data, required this.type, required this.ttl});

  factory AnswerDTO.fromJson(Map<String, dynamic> json) {
    return AnswerDTO(
        name: json['name'],
        data: json['data'],
        type: int.parse(json['type'].toString()),
        ttl: int.parse(json['ttl'].toString())
    );
  }

  @override
  String toString() {
    return 'AnswerDTO{name: $name, data: $data, type: $type, ttl: $ttl}';
  }
}