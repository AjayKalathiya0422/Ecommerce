import 'dart:convert';
import 'dart:io';

import 'package:apiloginpage/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class signuppage extends StatefulWidget {
  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  TextEditingController nam = TextEditingController();
  TextEditingController eml = TextEditingController();
  TextEditingController pas = TextEditingController();
  TextEditingController dobe = TextEditingController();
  TextEditingController fiel = TextEditingController();
  TextEditingController imag = TextEditingController();
  bool emailstatus = false;
  final List<String> items = [
    'Graduate',
    'Post-Graduate',
    'HSC',
    'SSC',
    'Other Qualification'
  ];

  bool vis = true;

  DateTime dateTime = DateTime.now();
  String Defultvalue = "";
  bool password = true;
  File? selectedimage;
  String baseimage = "";
  String image = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/pic1.jpg"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: EdgeInsets.only(left: 80, top: 100),
            child: Text("Sign Up",
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 50,
                    fontWeight: FontWeight.bold)),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.22,
                  left: 45,
                  right: 45),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          elevation: 50,
                          context: context,
                          builder: (context) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(width: 5),
                                image: DecorationImage(
                                  image: AssetImage("images/bb.webp"),
                                  fit: BoxFit.fill,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black54, BlendMode.darken),
                                ),
                              ),
                              height: 200,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(17),
                                    child: InkWell(
                                      onTap: () async {
                                        final ImagePicker _picker =
                                            ImagePicker();
                                        // Pick an image
                                        final XFile? photo =
                                            await _picker.pickImage(
                                                source: ImageSource.gallery);
                                        setState(() {
                                          image = photo!.path;
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 300,
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade100
                                              ?.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: Border.all(
                                              width: 2, color: Colors.blue),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(Icons.image,
                                                size: 40, color: Colors.blue),
                                            Text(
                                              "Browse Gallery",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final ImagePicker _picker = ImagePicker();
                                      // Capture a photo
                                      final XFile? photo =
                                          await _picker.pickImage(
                                              imageQuality: 25,
                                              source: ImageSource.camera);
                                      setState(() {
                                        image = photo!.path;
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade100
                                            ?.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            width: 2, color: Colors.blue),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.camera_alt,
                                            size: 40,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                            "Use a Camera",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(File(image)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: nam,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_outlined),
                      fillColor: Colors.blue.shade100,
                      filled: true,
                      hintText: "Nane",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: eml,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      fillColor: Colors.blue.shade100,
                      filled: true,
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.blue),
                      color: Colors.blue.shade200.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16)),
                  child: Container(
                    child: TextField(
                        controller: dobe, //editing controller of this TextField
                        decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            //icon of text field
                            labelText: "Enter Date of Birth",
                            labelStyle:
                                TextStyle(fontSize: 20) //label text of field
                            ),
                        readOnly: true, // when true user cannot edit text
                        onTap: () async {
                          //when click we have to show the datepicker
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              //get today's date
                              firstDate: DateTime(1990),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            print(
                                pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                            String formattedDate = DateFormat('dd-MM-yyyy').format(
                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                            print(
                                formattedDate); //formatted date output using intl package =>  2022-07-04
                            //You can format date as per your need

                            setState(() {
                              dobe.text =
                                  formattedDate; //set foratted date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        }),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 2),
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade200.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16)),
                  child: TextField(
                    controller: fiel,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      hintText: 'Qualification',
                      prefixIcon: Icon(Icons.list_alt_outlined),
                      suffixIcon: PopupMenuButton<String>(
                        icon: const Icon(Icons.arrow_drop_down),
                        onSelected: (String value) {
                          fiel.text = value;
                        },
                        itemBuilder: (BuildContext context) {
                          return items
                              .map<PopupMenuItem<String>>((String value) {
                            return new PopupMenuItem(
                                child: new Text(value), value: value);
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: pas,
                  obscureText: vis,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              vis = !vis;
                            });
                          },
                          icon: Icon(
                              vis ? Icons.visibility_off : Icons.visibility)),
                      fillColor: Colors.blue.shade100,
                      filled: true,
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.convex,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
                        depth: 8,
                        lightSource: LightSource.topLeft,
                        color: Colors.blue),
                    child: InkWell(
                      onTap: () async {
                        String name = nam.text;
                        String email = eml.text;
                        String dob = dobe.text;
                        String field = fiel.text;
                        String pasword = pas.text;
                        List<int> ii = File(image).readAsBytesSync();
                        String imagedata = base64Encode(ii);

                        Map map = {
                          "name": name,
                          "email": email,
                          "dob": dob,
                          "course": field,
                          "password": pasword,
                          "imagedata": imagedata,
                        };

                        var url = Uri.parse(
                            'https://riyaanjiyaanpage.000webhostapp.com/apicalling/register.php');
                        var response = await http.post(url, body: map);
                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');
                        var mm = jsonDecode(response.body);
                        mysigndata bb = mysigndata.fromJson(mm);
                        if (bb.connection == 1) {
                          if (bb.result == 1) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Register Successfully")));
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return apiloginpage();
                              },
                            ));
                          }
                          else if (bb.result == 2) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Allredy Exit")));
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return apiloginpage();
                              },
                            ));
                          }
                        }
                      },
                      child: Container(
                        child: Center(
                            child: Text(
                          "Submit",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25),
                        )),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                    ),
                  ),
                )
              ]),
            ),
          )
        ]),
      ),
    );
  }
}

class mysigndata {
  int? connection;
  int? result;

  mysigndata({this.connection, this.result});

  mysigndata.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}
