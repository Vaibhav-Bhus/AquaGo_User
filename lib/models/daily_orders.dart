import 'package:flutter/material.dart';

class DailyHistory {
  String? address;
  int? dayFrequency;
  int? jarFrequency;
  String? num;
  String? sellerUid;
  String? time;
  String? name;

  DailyHistory({
    this.address,
    this.dayFrequency,
    this.jarFrequency,
    this.num,
    this.sellerUid,
    this.name,
    this.time,
  });

  DailyHistory.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    dayFrequency = json['dayFrequency'];
    jarFrequency = json['jarFrequency'];
    num = json['num'];
    name = json['name'];
    sellerUid = json['sellerUid'];
    time = json['time'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['address'] = address;
    data['dayFrequency'] = dayFrequency;
    data['jarFrequency'] = jarFrequency;
    data['num'] = num;
    data['sellerUid'] = sellerUid;
    data['time'] = time;

    return data;
  }
}
