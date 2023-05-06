// ignore_for_file: unused_label

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? num;
  String? id;
  String? firstName;
  String? lastName;
  String? buisnessName;
  // String? userAddress;
  String? userMail;
  // DateTime? dob;
  // String? userCity;
  // String? userGender;
  String? userPic;
  UserModel(
      {this.id,
      this.num,
      this.firstName,
      this.lastName,
      // this.userAddress,
      this.buisnessName,
      this.userMail,
      // this.dob,
      // this.userCity,
      // this.userGender,
      this.userPic});

  Map<String, dynamic> toJson() => {
        "id": id,
        "num": num,
        "firstName": firstName,
        "lastName": lastName,
        "userMail": userMail,
        "buisnessName": buisnessName,
        // "userGender": userGender,
        "userPic": userPic,
      };

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      id: snapshot["id"],
      num: snapshot['num'] ?? '',
      firstName: snapshot['firstName'] ?? '',
      lastName: snapshot['lastName'] ?? '',
      userMail: snapshot['userMail'] ?? '',
      buisnessName: snapshot['buisnessName'] ?? '',
      // dob:
      // DateTime.parse(map['dob']) ?? Timestamp.now(),
      // userGender: snapshot['userGender'] ?? '',
      userPic: snapshot['userPic'] ?? '',
    );
  }
}
