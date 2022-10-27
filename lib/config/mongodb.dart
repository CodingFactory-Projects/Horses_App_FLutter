// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names

import 'dart:developer';
import 'package:horses_app/class/RegisterModel.dart';

import 'constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection, loggedUser;

  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
  }

  static insertUser(String Collection, Model) async {
    var userCollection = db.collection(Collection);
    await userCollection.insertOne(Model.toJson());
  }

  static Future<List<Map<String, dynamic>>> getData(String Collection) async{
    var userCollection = db.collection(Collection);
    final arrData = await userCollection.find().toList();
    return arrData;
  }
}
