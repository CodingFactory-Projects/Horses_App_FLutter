

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:horses_app/config/EventController.dart';
import 'package:horses_app/config/UserController.dart';
import 'package:image_picker/image_picker.dart';

class CursusForm extends StatefulWidget {
  const CursusForm({super.key, required this.title});

  final String title;

  @override
  State<CursusForm> createState() => _CursusFormState();
}

class _CursusFormState extends State<CursusForm> {

  File? imagee;
  @override
  Widget build(BuildContext context) {

    Future getImage() async {
      final _picker = ImagePicker();
      var image = await _picker.getImage(source: ImageSource.gallery, imageQuality: 1);
      imagee = File(image!.path) ;
      print('Image Path $imagee');
      setState(() {});
    }

    TextEditingController delay = TextEditingController();
    TextEditingController disciplineController = TextEditingController();
    TextEditingController dateController = TextEditingController();

    return Form(

        child: Column(
          children: [
            TextField(
              controller: delay,
              style: const TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Enter the name event",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: disciplineController,
              style: const TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Enter the adress  event",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: dateController,
              style: const TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: "Enter your date",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Color(0xff476cfb),
                    child: ClipOval(
                      child: SizedBox(
                        width: 200.0,
                        height: 200.0,
                        child: (imagee !=null)?Image.file(
                          imagee!,
                          fit: BoxFit.fill,
                        ):Image.network(
                          "https://img2.freepng.fr/20180626/rjb/kisspng-chess-piece-knight-pawn-jeu-des-petits-chevaux-cavalier-5b32f1dbb39f26.1181595015300653717357.jpg",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.font_download_sharp,
                      size: 30.0,
                    ),
                    onPressed: () {
                      getImage();
                    },
                  ),),],),
            MaterialButton(
              minWidth: double.infinity,
              height:60,
              onPressed: (){
                if(imagee != null ){
                  final bytes = imagee!.readAsBytesSync();
                  String base64Image =  base64Encode(bytes);
                  var userController = EventController();
                  var user =  Cursus(
                      delay.value.text,
                      disciplineController.value.text,
                      dateController.value.text,
                      base64Image,

                  );
                  userController.insertEvent(user);



                }
              },
              color: Colors.redAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
              ),
              child: const Text("add cursus",style: TextStyle(
                fontWeight: FontWeight.w600,fontSize: 16,
              ),),
            ),
          ],
        )
    );

  }
}


