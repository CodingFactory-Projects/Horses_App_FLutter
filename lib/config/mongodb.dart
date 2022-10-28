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
<<<<<<< Updated upstream
}
=======

  static addHorse(HorseModel model) async {
    Map<String, dynamic> json = {
      "_id": '',
      "username": '',
      "email": '',
      "password": '',
      "image": '',
      "age": '',
      "phoneNumber": '',
      "profilFFE": '',
    };

    json['_id'] = ObjectId();

    var userCollection = db.collection('horses');
    await userCollection.insert(json);
    return json['_id'].$oid;
  }

  static updateHorse(String? originalName, HorseModel horse) async {
    currCollection = db.collection('horses');

    var u = await currCollection.findOne({'name': originalName});

    if (u.length == 0) {
      return;
    }

    u['name'] = horse.name;
    u['photo'] = horse.photo;
    u['age'] = horse.age;
    u['dress'] = horse.dress;
    u['race'] = horse.race;
    u['gender'] = horse.gender;
    u['speciality'] = horse.speciality;

    await currCollection.save(u);
  }

  static deleteHorse(String? name) async {
    currCollection = db.collection('horses');
    await currCollection.remove({"name": name});
  }
}
>>>>>>> Stashed changes
