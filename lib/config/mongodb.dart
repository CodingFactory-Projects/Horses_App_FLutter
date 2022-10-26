import 'dart:developer';
import 'constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var collectionUsers = db.collection(COLLECTION_USERS);
    var collectionHorses = db.collection(COLLECTION_HORSES);

    // await collection.insertOne({
    //   'email': 'admin@admin.fr',
    //   'username': 'admin',
    //   'password': 'admin',
    // });

    // await collection.update( where.eq('email', 'admin@admin.fr'), modify.set('password', 'admin3'));

    // await collection.remove(where.eq('email', 'admin@admin.fr'));

    // print(await collectionUsers.find().toList());
    // print(await collectionHorses.find().toList());
  }
}
