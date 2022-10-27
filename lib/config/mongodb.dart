// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:horses_app/class/RegisterModel.dart';

import 'constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection, idUser;

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
}
