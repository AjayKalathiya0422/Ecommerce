import 'dart:convert';
import 'dart:io';
import 'package:apiloginpage/startpage.dart';
import 'package:apiloginpage/viewproduct.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'homepage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class updatepage extends StatefulWidget {
  Productdata productdata;

  updatepage(this.productdata);

  @override
  State<updatepage> createState() => _updatepageState();
}

class _updatepageState extends State<updatepage> {
  updatedataa? up;
  int img = 0;


  String image = "";
  TextEditingController pname = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController prize = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pname.text = widget.productdata.productname!;
    desc.text = widget.productdata.description!;
    prize.text = widget.productdata.productprize!;
    image= widget.productdata.proimage!;

    print("##=========================$img");
  }

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
                            setState(() {
                              img=1;
                            });
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
                                                    source:
                                                        ImageSource.gallery);
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
                                                    size: 40,
                                                    color: Colors.blue),
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
                          child: img == 1
                              ? CircleAvatar(
                                  maxRadius: 50,
                                  backgroundImage: FileImage(File(image)),
                                )
                              : CircleAvatar(radius: 80,
                                  backgroundImage: NetworkImage(
                                      "https://riyaanjiyaanpage.000webhostapp.com/apicalling/${widget.productdata.proimage}"))),
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

                      List<int> ii = File(image).readAsBytesSync();
                      String imagedata = base64Encode(ii);
                      String? imagedata1 = widget.productdata.proimage;

                      Map map = {
                        "Pname": pname.text,
                        "Prise": prize.text,
                        "Descr": desc.text,
                        "image": imagedata,
                        "imag1": imagedata1,
                        "loginid": widget.productdata.iD,
                      };

                      print("##=================$map");

                      var url = Uri.parse(
                          'https://riyaanjiyaanpage.000webhostapp.com/apicalling/update.php');
                      var response = await http.post(url, body: map);
                      print('Response status: ${response.statusCode}');
                      print('Response body: ${response.body}');

                      var mm = jsonDecode(response.body);
                      updatedataa up = updatedataa.fromJson(mm);

                      print("====$up");
                      if (up.connection == 1) {
                        if (up.result == 1) {

                          EasyLoading.dismiss(animation: false);
                          EasyLoading.showSuccess('Update Success!');
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return homepage();
                            },
                          ));
                        }
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
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
}

class updatedataa {
  int? connection;
  int? result;

  updatedataa({this.connection, this.result});

  updatedataa.fromJson(Map<String, dynamic> json) {
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
