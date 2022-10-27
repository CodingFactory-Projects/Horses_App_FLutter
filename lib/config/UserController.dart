

import 'package:horses_app/config/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart';

class User{
   ObjectId? id;
   String username;
   String mail;
   String password;
   String image;
  String phone;
   int age;
   String link_ffe;

  User( {required this.username, required this.mail, required this.password, required this.image, required this.phone,
     required  this.age, required this.link_ffe, this.id});

   factory User.fromJson(Map<String, dynamic> json) => User(
     id: json["_id"],
     username: json["username"],
     mail: json["email"],
     password: json["password"],
     image: json["profilePicture"],
     phone: json["phoneNumber"],
     age: json["age"],
     link_ffe: json["ffeLink"],


   );
}

class UserController{

  insertUser(User user) async {
    print(user.username);
    var Db = await MongoDatabase.getUserDb();
    await Db.insertOne(<String, dynamic>{
      'username': user.username,
      'password': user.password,
      'email': user.mail,
      "profilePicture": user.image,
      "phoneNumber" : user.phone,
      "age" : user.age,
      "ffeLink" : user.link_ffe,
      "dp" :"Oui"

    });
  }

  UpdateUser(User user) async{
    var Db = await MongoDatabase.getUserDb();

  }


  getUserById(id) async{
    var Db = await MongoDatabase.getUserDb();
    var res = await Db.findOne(where.eq("id", id));
    User.fromJson(res);

  }


}

