// To parse this JSON data, do
//     final registerModel = registerModelFromJson(jsonString);
// ignore_for_file: file_names

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    required this.username,
    required this.email,
    required this.password,
    required this.photo,
    this.age,
  });

  String username;
  String email;
  String password;
  String photo;
  int? age;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        photo: json["image"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "image": photo,
        "age": age,
      };
}
