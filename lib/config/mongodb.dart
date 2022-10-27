// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:horses_app/class/RegisterModel.dart';

import 'constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection, loggedUser = [];

  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
  }

  static search(collection, value) {
    return where.eq(collection, value);
  }

  static insertUser(Model) async {
    loggedUser.add(Model.toJson());
    print(loggedUser[0]["username"]);
  }

  static Future<List<Map<String, dynamic>>> getData(String Collection) async {
    var userCollection = db.collection(Collection);
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  static logout() async {
    loggedUser = [];
    print(loggedUser);
    // print(loggedUser[0]["username"]);
  }

  static loginUser(String username, String password) {
    var userCollection = db.collection("users");
    var query = where.eq("username", username).eq("password", password);
    userCollection.findOne(query).then((value) {
      if (value != null) {
        loggedUser.add(value);
      } else {
        print("Wrong username or password");
      }
    });
  }
}
