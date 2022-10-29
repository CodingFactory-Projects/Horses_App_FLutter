import 'package:mongo_dart/mongo_dart.dart';

class HorseModel {
  ObjectId id;
  ObjectId ownerId;
  String? name;
  String? photo;
  String? age;
  String? dress;
  String? race;
  String? gender;
  String? speciality;

  HorseModel(this.id, this.ownerId ,this.name, this.photo, this.age, this.dress, this.race,
      this.gender, this.speciality);
}
