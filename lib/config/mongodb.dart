// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:horses_app/class/HorseModel.dart';
import 'package:horses_app/class/RegisterModel.dart';

import 'constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection, horsesCollection, idUser;

  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
  }

  static Future<String> register(RegisterModel data) async {
    try {
      userCollection = db.collection('users');
      var result = await userCollection.insert(data.toJson());
      if (result.isSuccess) {
        return "success";
      } else {
        return "error";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static search(collection, value) {
    return where.eq(collection, value);
  }

  static getUserId(userId) async {
    idUser = userId;
    // print(idUser);
  }

  // get user by is id
  static Future<List> getUserById() async {
    userCollection = db.collection('users');
    var result = await userCollection.find(where.eq('_id', idUser)).toList();
    // print(result);
    return result;
  }

  static Future<List<Map<String, dynamic>>> getHorses() async {
    horsesCollection = db.collection("horses");
    final result = await horsesCollection.find(where.eq("_ownerId", idUser)).toList();
    // print(result);
    return result;
  }


  static insertUserId(userId) async {
    idUser = await userId;
    print(idUser);
  }

  static Future<List<Map<String, dynamic>>> getData(String Collection) async {
    var userCollection = db.collection(Collection);
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  static Future<List<Map<String, dynamic>>> getDataById() async {
    final data = await userCollection.find(where.gt("_id", idUser)).toList();
    print(data);
    return data;
  }

  static Future<void> updateUser(var id, String? photo, String? age,
      String? phoneNumber, String? profilFFE) async {
    var result = await userCollection.findOne({"_id": idUser});
    result["photo"] = photo;
    result["age"] = age;
    result["phoneNumber"] = phoneNumber;
    result["profilFFE"] = profilFFE;
    var response = await userCollection.save(result);
  }

  static insertUser(String collection, model) async {
    var userCollection = db.collection(collection);
    await userCollection.insert(model.toJson());
  }

  static addHorse(HorseModel model) async {
    var userCollection = db.collection('horses');
    var query = await userCollection.insert();
    print(query);
    // return json['_id'].$oid;
  }

  // static updateHorse(String? originalName, HorseModel horse) async {
  //   currCollection = db.collection('horses');
  //   var query = await currCollection.findOne({"name": originalName});
  //
  // }

  static Future<void> updateHorse(
      var id,
      String? name,
      String? photo,
      String? age,
      String? dress,
      String? race,
      String? gender,
      String? speciality) async {
    var result = await horsesCollection.findOne({"_id": id});

    result["name"] = name;
    result["photo"] = photo;
    result["age"] = age;
    result["dress"] = dress;
    result["race"] = race;
    result["gender"] = gender;
    result["speciality"] = speciality;

    var response = await horsesCollection.save(result);

    print("result : " + result);
    // print("response : " + response);
  }

  static deleteHorse(String? name) async {
    horsesCollection = db.collection('horses');
    await horsesCollection.remove({"name": name});
  }
}
