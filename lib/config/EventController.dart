import 'package:mongo_dart/mongo_dart.dart';

import 'mongodb.dart';

class Event{
  ObjectId? id;
  String date;
  String image;
  String typeEvent;
  Event(this.date, this.image, this.typeEvent);
}

class Party extends Event{
  Party(super.date, super.image,[super.typeEvent = 'party']);
  factory Party.fromJson(Map<String, dynamic> json) => Party(
    json["date"],
    json["image"],

  );
}

class Contest extends Event{
String? name;

Contest(this.name, this.adress, this.level,super.date, super.image ,[super.typeEvent = 'contest']);
  String? adress;
  String? level;

factory Contest.fromJson(Map<String, dynamic> json) => Contest(
  json["name"],
  json["adress"],
  json["level"],
  json["date"],
  json["image"],

);
}

class Cursus extends Event{
    String delay;
    Cursus(this.delay, this.discipline, super.date, super.image, [super.typeEvent = 'cursus']);
    String discipline;

    factory Cursus.fromJson(Map<String, dynamic> json) => Cursus(
        json["date"],
        json["image"],
        json["delay"],
        json["discipline"],

    );
}

class EventController{

  insertEvent(event) async{
    var Db = await MongoDatabase.getEventDb();
    print(Db);
    print(event.typeEvent);
    print(event.image);
    print(event.date);

      switch(event.typeEvent){
        case 'party':{
          await Db.insertOne(<String, dynamic>{
            'type_event': event.typeEvent,
            'image': event.image,
            'date': event.date,
            "name" : '',
            "adress" : '',
            "delay" : '',
            "discipline" : '',
            "level" : ''

          });
        }
        break;
        case 'contest':{
          await Db.insertOne(<String, dynamic>{
            'type_event': event.typeEvent,
            'image': event.image,
            'date': 'event.date',
            "name" : event.name,
            "adress" : event.adress,
            "delay" : '',
            "discipline" : '',
            "level" : ''

          });
        }
        break;
        case 'cursus':{
          await Db.insertOne(<String, dynamic>{
            'type_event': event.typeEvent,
            'image': event.image,
            'date': event.date,
            "name" : '',
            "adress" : '',
            "delay" : event.delay,
            "discipline" : event.discipline,
            "level" : ''

          });
        }
        break;

      }
  }


  getConstestEvents() async{
    var Db = await MongoDatabase.getEventDb();
    var res = await Db.findOne(where.eq("type_event", "contest"));

    var coll = await Contest.fromJson(res);
    print(coll.name);
    return coll;
  }

  getCursusEvents() async{
    var Db = await MongoDatabase.getEventDb();
    var res = await Db.findAll(where.eq("type_event", "cursus"));
    return Cursus.fromJson(res);
  }

  getPartytEvents() async{

    var Db = await MongoDatabase.getEventDb();
    var res = await Db.find(where.eq("type_event", "party"));

    return Party.fromJson(res);
  }
}