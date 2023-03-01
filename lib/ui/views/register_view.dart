import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:moneymanager/ui/shared/dimensions/dimensions.dart';
import 'package:moneymanager/ui/views/sign_in_view.dart';

import '../../core/services/AuthServices.dart';
import '../widgets/alert_task_view_widget/alert_task.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  File? _image;
  bool check = false;
  String _selectedItem = 'item_2';

  final _formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController gsmController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                  key: _formkey,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(90),
                              ),
                              gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
                                Colors.blueGrey,
                                Colors.indigo,
                              ]),
                            ),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 50),
                                  child: Image(
                                    image: AssetImage('images/camping.png'),
                                    height: 90,
                                    width: 90,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text(
                                    'Créer un compte Campino',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        //  fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                )
                              ],
                            )),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 6),
                              ),
                            ]),
                            height: 50,
                            child: TextFormField(
                              controller: nameController,
                              validator: (Value) {
                                if (Value!.isEmpty || !(RegExp(r'^[a-z A-Z]+$')).hasMatch(Value))
                                  return "s'il vous plait saisir un nom valide ";
                              },
                              keyboardType: TextInputType.name,
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.indigo,
                                ),
                                hintText: 'Nom Complet',
                                hintStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 6),
                              ),
                            ]),
                            height: 50,
                            child: TextFormField(
                              controller: emailcontroller,
                              validator: (Value) {
                                if (Value!.isEmpty) return "s'il vous plait saisir un email valide ";
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.indigo,
                                ),
                                hintText: 'exemple@gmail.com',
                                hintStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 6),
                              ),
                            ]),
                            height: 50,
                            child: TextFormField(
                              controller: gsmController,
                              validator: (Value) {
                                if (Value!.isEmpty || (RegExp(r'^[0..9]+$')).hasMatch(Value))
                                  return "s'il vous plait saisir votre numéro de télephone  ";
                                else if (Value.length > 8) return "le numéro de téléphone ne dépasse pas 8 chiffres  ";
                              },
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.indigo,
                                ),
                                hintText: '12345678 ',
                                hintStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 6),
                              ),
                            ]),
                            height: 50,
                            child: TextFormField(
                              controller: _passController,
                              validator: (Value) {
                                if (Value!.isEmpty || Value.length < 8)
                                  return " saisir un mot de passe  valide de 8 caractères  ";
                              },
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.indigo,
                                ),
                                hintText: 'Mot de passe',
                                hintStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: Constants.screenHeight * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: DropdownButton<String>(
                                value: _selectedItem,
                                underline: SizedBox(
                                  height: 0,
                                ),
                                items: [
                                  DropdownMenuItem(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Gestionnaire de centre de camping',
                                        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                                      ),
                                    ),
                                    value: 'item_1',
                                  ),
                                  DropdownMenuItem(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Utilisateur normal',
                                        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                                      ),
                                    ),
                                    value: 'item_2',
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedItem = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          loading
                              ? CircularProgressIndicator()
                              : Container(
                                  padding: EdgeInsets.symmetric(horizontal: 26),
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: CupertinoButton(
                                              child: Text(
                                                'S\'inscrire',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontStyle: FontStyle.italic, // fontWeight: FontWeight.bold )
                                                ),
                                              ),
                                              color: Colors.indigo,
                                              onPressed: () async {
                                                if (_formkey.currentState!.validate() && !_image.isNull) {
                                                  setState(() {
                                                    loading = true;
                                                  });

                                                  bool check = await AuthServices()
                                                      .signUp(emailcontroller.text, _passController.text, nameController.text);

                                                  if (check) {
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                    alertTask(
                                                      lottieFile: "images/success.json",
                                                      action: "Connecter",
                                                      message: "Votre compte a été créé avec succès",
                                                      press: () {
                                                        Get.to(() => SignInScreen());
                                                      },
                                                    ).show(context);
                                                  } else {
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                    alertTask(
                                                      lottieFile: "images/error.json",
                                                      action: "Ressayer",
                                                      message: "Email déja existe",
                                                      press: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ).show(context);
                                                  }
                                                } else if (_image.isNull) {
                                                  Fluttertoast.showToast(
                                                      msg: "Image obligatoire",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.grey,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                }
                                              }))
                                    ],
                                  )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: Constants.screenHeight * 0.07,
                          width: double.infinity,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.to(SignInScreen());
                                },
                                icon: Icon(Icons.arrow_back_ios),
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: Constants.screenHeight * 0.08,
                              ),
                              Text(
                                "Creér un compte",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic, color: Colors.white, fontSize: Constants.screenHeight * 0.03),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )))),
    );
  }
}
