class BulkOrders {
  String? address;
  double? amt;
  int? chilledBottle;
  int? chilledJar;
  String? custUid;
  String? dateToDeliver;
  String? floor;
  int? normalBottle;
  int? normalJar;
  int? orderId;
  String? orderStatus;
  String? paymentStatus;
  String? shopName;
  String? storeUid;
  String? timeToDeliver;

  BulkOrders(
      {this.address,
      this.amt,
      this.chilledBottle,
      this.chilledJar,
      this.custUid,
      this.dateToDeliver,
      this.floor,
      this.normalBottle,
      this.normalJar,
      this.orderId,
      this.orderStatus,
      this.paymentStatus,
      this.shopName,
      this.storeUid,
      this.timeToDeliver});

  BulkOrders.fromJson(Map<String, dynamic> json) {
    address = json["address"];
    amt = json['amt'];
    chilledBottle = json['chilledBottle'];
    chilledJar = json['chilledJar'];
    custUid = json['custUid'];
    dateToDeliver = json['dateToDeliver'];
    floor = json['floor'];
    normalBottle = json['normalBottle'];
    normalJar = json['normalJar'];
    orderId = json['orderId'];
    orderStatus = json['orderStatus'];
    paymentStatus = json['paymentStatus'];
    shopName = json['shopName'];
    storeUid = json['storeUid'];
    timeToDeliver = json['timeToDeliver'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['address'] = address;
    data["amt"] = amt;
    data['chilledBottle'] = chilledBottle;
    data['custUid'] = custUid;
    data['dateToDeliver'] = dateToDeliver;
    data['floor'] = floor;
    data['normalBottle'] = normalBottle;
    data['normalJar'] = normalJar;
    data['orderId'] = orderId;
    data['orderStatus'] = orderStatus;
    data['paymentStatus'] = paymentStatus;
    data['shopName'] = shopName;
    data['storeUid'] = storeUid;
    data['timeToDeliver'] = timeToDeliver;

    return data;
  }
}