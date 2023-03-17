import 'dart:convert';
import 'dart:io';

import 'package:apiloginpage/homepage.dart';
import 'package:apiloginpage/startpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class addproduct extends StatefulWidget {
  const addproduct({Key? key}) : super(key: key);

  @override
  State<addproduct> createState() => _addproductState();
}

class _addproductState extends State<addproduct> {
  String image = "";
  TextEditingController pname = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController prize = TextEditingController();

  bool emailstatus = false;
  bool vis = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.09,
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
                                        final ImagePicker _picker =
                                            ImagePicker();
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
                                          borderRadius:
                                              BorderRadius.circular(16),
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
                    controller: pname,
                    decoration: InputDecoration(
                        fillColor: Colors.blue.shade100,
                        filled: true,
                        hintText: "Product Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: prize,
                    decoration: InputDecoration(
                        fillColor: Colors.blue.shade100,
                        filled: true,
                        hintText: "Product Prize",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    maxLines: 10,
                    controller: desc,
                    decoration: InputDecoration(
                        fillColor: Colors.blue.shade100,
                        filled: true,
                        hintText: "Description",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      EasyLoading.show(status: 'loading...');
                        String productname = pname.text;
                        String productprize = prize.text;
                        String Description = desc.text;
                        String id=startpage.prefrs!.getString("iD")??"";

                        List<int> ii = File(image).readAsBytesSync();
                        String imagedata = base64Encode(ii);

                        Map map = {
                          "Pname": productname,
                          "Prise": productprize,
                          "Descr": Description,
                          "image": imagedata,
                           "loginid": id,
                        };
                        var url = Uri.parse(
                            'https://riyaanjiyaanpage.000webhostapp.com/apicalling/addproduct.php');
                        var response = await http.post(url, body: map);
                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');

                        var mm = jsonDecode(response.body);
                        myaddproduct bb = myaddproduct.fromJson(mm);

                        print("====$bb");
                        if (bb.connection == 1) {
                          if (bb.result == 1) {
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //     content: Text("Register Successfully")));
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return homepage();
                                  },
                                ));
                            EasyLoading.dismiss(animation: false);
                            EasyLoading.showSuccess('Success!');
                          }
                          else if (bb.result == 2) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Allredy Exit")));
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return homepage();
                                  },
                                ));
                          }
                        }
                      },
                    child: Container(height: 50,width: 200,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ],
          )
        ],
      ),
    );
  }
}class myaddproduct {
  int? connection;
  int? result;

  myaddproduct({this.connection, this.result});

  myaddproduct.fromJson(Map<String, dynamic> json) {
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



