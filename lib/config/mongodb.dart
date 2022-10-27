import 'dart:developer';

import '../class/UserModel.dart';
import 'constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, currCollection;

  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
  }

  static insertUser(String collection, model) async {
    var userCollection = db.collection(collection);
    await userCollection.insert(model.toJson());
  }

  static select(String collection, ) async {
    currCollection = db.collection(collection);
    var profile = await currCollection.find().toList();
    profile = profile.first; //à remplacer avec l'id
    return profile;
  }

  static updateUser(UserModel user) async {
    currCollection = db.collection('users');

    final u = await currCollection.findOne();

    u['phoneNumber'] = user.phoneNumber;
    u['age'] = user.age;
    u['ffeLink'] = user.ffeLink;
    u['dp'] = user.dp;

    await currCollection.save(u);
  }
}