import 'dart:convert';

HorseModel registerModelFromJson(String str) =>
    HorseModel.fromJson(json.decode(str));

String registerModelToJson(HorseModel data) => json.encode(data.toJson());

class HorseModel {
  HorseModel({
    required this.name,
    required this.photo,
    required this.age,
    required this.dress,
    required this.race,
    required this.gender,
    required this.speciality
  });

  String? id;
  String? name;
  String? photo;
  String? age;
  String? dress;
  String? race;
  String? gender;
  String? speciality;

  factory HorseModel.fromJson(Map<String, dynamic> json) => HorseModel(
    name: json['name'],
    photo: json['photo'],
    age: json['age'],
    dress: json['dress'],
    race: json['race'],
    gender: json['gender'],
    speciality: json['speciality']
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'photo': photo,
    'age': age,
    'dress': dress,
    'race': race,
    'gender': gender,
    'speciality': speciality
  };
}