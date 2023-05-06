// ignore_for_file: unused_label

class Address {
  int? floorNo;
  String? liftAvailability;
  String? street;
  String? area;
  String? city;
  String? pinCode;

  Address(
      {this.floorNo,
      this.liftAvailability,
      this.street,
      this.area,
      this.city,
      this.pinCode});

  Map<String, dynamic> toMap(Address add) {
    final map = <String, dynamic>{};

    map['floorNo'] = add.floorNo;
    map['liftAvailability'] = add.liftAvailability;
    map['street'] = add.street;
    map['area'] = add.area;
    map['city'] = add.city;
    map['pinCode'] = add.pinCode;

    return map;
  }

  Address.fromMap(Map<String, dynamic> map) {
    floorNo:
    map['floorNo'] ?? 0;
    liftAvailability:
    map['liftAvailability'] ?? '';
    street:
    map['street'] ?? '';
    area:
    map['area'] ?? '';
    city:
    map['city'] ?? '';
    pinCode:
    map['pinCode'] ?? '';
  }
}
