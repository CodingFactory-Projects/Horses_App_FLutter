

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:horses_app/config/UserController.dart';
import 'package:image_picker/image_picker.dart';

class PartyForm extends StatefulWidget {
  const PartyForm({super.key, required this.title});

  final String title;

  @override
  State<PartyForm> createState() => _PartyFormState();
}

class _PartyFormState extends State<PartyForm> {

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
    TextEditingController nameController = TextEditingController();
    TextEditingController mailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var _formKey = GlobalKey<FormState>();
    return Scaffold(

        body: Container(
            margin: const EdgeInsets.only(left: 35, right: 35, top: 80),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      style: const TextStyle(color: Colors.white),
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
                          hintText: "Enter your username",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: mailController,
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
                          hintText: "Enter your e-mail",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: passwordController,
                      style: const TextStyle(color: Colors.white),
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
                          hintText: "Enter your name",
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
                          var userController = UserController();
                          var user =  User(
                            username : nameController.value.text,
                            mail : mailController.value.text,
                            password: passwordController.value.text,
                            image: base64Image,
                            phone:'oui',
                            age :0,
                            link_ffe:  '',
                          );
                          userController.insertUser(user);

                        }
                      },
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)
                      ),
                      child: const Text("Register Your Account",style: TextStyle(
                        fontWeight: FontWeight.w600,fontSize: 16,
                      ),),
                    ),
                  ],
                )
            )
        )

    );

  }
}
