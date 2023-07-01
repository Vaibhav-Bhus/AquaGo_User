
class Seller {
  String? sellerName;
  String? sellerUID;
  String? address;
  String? sellerAvatarUrl;
  String? waterType;
  String? phone;

  Seller(
      {this.sellerName,
      this.sellerUID,
      this.address,
      this.sellerAvatarUrl,
      this.waterType,
      this.phone});

  Seller.fromJson(Map<String, dynamic> json) {
    sellerName = json["sellerName"];
    sellerUID = json['sellerUID'];
    address = json['address'];
    sellerAvatarUrl = json['sellerAvatarUrl'];
    waterType = json['waterType'];
    phone = json['phone'];
    print('all set to go');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["sellerName"] = sellerName;
    data['sellerUID'] = sellerUID;
    data['address'] = address;
    data['sellerAvatarUrl'] = sellerAvatarUrl;
    data['waterType'] = waterType;

    return data;
  }
}
