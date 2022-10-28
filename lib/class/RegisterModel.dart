// To parse this JSON data, do
//     final registerModel = registerModelFromJson(jsonString);
// ignore_for_file: file_names

import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel(
      {required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.photo,
      this.age,
      this.phoneNumber,
      this.profilFFE});

  ObjectId id;
  String username;
  String email;
  String password;
  String photo;
  int? age;
  String? phoneNumber;
  String? profilFFE;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        photo: json["image"],
        age: json["age"],
        phoneNumber: json["phoneNumber"],
        profilFFE: json["profilFFE"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "password": password,
        "image": photo,
        "age": age,
        "phoneNumber": phoneNumber,
        "profilFFE": profilFFE,
      };
}
