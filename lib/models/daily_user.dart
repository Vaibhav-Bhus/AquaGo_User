import 'package:flutter/material.dart';

class DailyUser {
  String? AreaName;
  String? buildingName;
  String? cityName;
  String? floor;
  String? houseNo;
  String? name;
  String? num;
  String? pinCode;
  String? streetName;
  String? uid;
  int? dayFrequency;
  int? jarFrequency;
  double? price;

  DailyUser({
    this.name,
    this.buildingName,
    this.AreaName,
    this.num,
    this.cityName,
    this.dayFrequency,
    this.floor,
    this.price,
    this.houseNo,
    this.jarFrequency,
    this.pinCode,
    this.streetName,
    this.uid,
  });
  DailyUser.fromJson(Map<String, dynamic> json) {
    AreaName = json['AreaName'];
    name = json["name"];
    buildingName = json['buildingName'];
    num = json['num'];
    price = json['price'].toDouble();
    cityName = json["cityName"];
    dayFrequency = json["dayFrequency"];
    floor = json["floor"];
    houseNo = json["houseNo"];
    jarFrequency = json["jarFrequency"];
    pinCode = json["pinCode"];
    streetName = json["streetName"];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = name;
    data['AreaName'] = AreaName;
    data['buildingName'] = buildingName;
    data['cityName'] = cityName;
    data['dayFrequency'] = dayFrequency;
    data['floor'] = floor;
    data['houseNo'] = houseNo;
    data['jarFrequency'] = jarFrequency;
    data['pinCode'] = pinCode;
    data['streetName'] = streetName;
    data['num'] = num;
    data['uid'] = uid;

    return data;
  }
}
