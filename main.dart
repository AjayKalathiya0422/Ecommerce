import 'dart:convert';

import 'package:apiloginpage/homepage.dart';
import 'package:apiloginpage/signuppage.dart';
import 'package:apiloginpage/startpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(MaterialApp(
    home: startpage(),
    builder: EasyLoading.init(),
    debugShowCheckedModeBanner: false,
  ));
  startpage.easyload();
}

class apiloginpage extends StatefulWidget {
  const apiloginpage({Key? key}) : super(key: key);

  @override
  State<apiloginpage> createState() => _apiloginpageState();
}

class _apiloginpageState extends State<apiloginpage> {
  bool vis = true;

  TextEditingController Email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool ema= false;
  bool pas= false;

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
            padding: EdgeInsets.only(left: 50, top: 180),
            child: Text("Welcome\nback",
                style: TextStyle(color: Colors.lightBlue, fontSize: 50)),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5,
                  left: 45,
                  right: 45),
              child: Column(children: [
                TextField(

                  controller: Email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      errorText: ema ? "Enter Email" : null,
                      prefixIcon: Icon(Icons.email),
                      fillColor: Colors.blue.shade100,
                      filled: true,
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onChanged: (value) {
                    setState(() {
                      if (value != "") {
                        setState(() {
                          ema = false;
                        });
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: password,
                  obscureText: vis,
                  decoration: InputDecoration(
                      errorText: pas ? "Enter Password" : null,
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
                  onChanged: (value) {
                    setState(() {
                      if (value != "") {
                        setState(() {
                          pas = false;
                        });
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(  onTap: () async {
                      String email = Email.text;
                      String pass = password.text;
                      Map mm = {"email": email, "password": pass};

                      // print("=============$mm");
                      var url = Uri.parse('https://riyaanjiyaanpage.000webhostapp.com/apicalling/log.php');
                      var response = await http.post(url, body: mm);
                      print('Response status: ${response.statusCode}');
                      print('Response body: ${response.body}');
                      var map = jsonDecode(response.body);
                      mylogindata ll=mylogindata.fromJson(map);

                      if (ll.connection == 1) {
                        if (ll.result == 1) {

                          String? id = ll.userdata!.iD;
                          String? name = ll.userdata!.nAME;
                          String? email = ll.userdata!.eMAIL;
                          String? Dob = ll.userdata!.dOB;
                          String? Course = ll.userdata!.cOURSE;
                          String? Password = ll.userdata!.pASSWORD;
                          String? imagee = ll.userdata!.iMAGE;

                          startpage.prefrs!.setBool("loginstatus", true);


                          startpage.prefrs!.setString("iD", id!);
                          startpage.prefrs!.setString("NAME", name!);
                          startpage.prefrs!.setString("eMAIL", email!);
                          startpage.prefrs!.setString("dOB", Dob!);
                          startpage.prefrs!.setString("cOURSE", Course!);
                          startpage.prefrs!.setString("pASSWORD", Password!);
                          startpage.prefrs!.setString("Image", imagee!);

                          // print("== $name == $imagee");
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return homepage();
                            },
                          ));
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("User Not Found")));
                        }
                      }
                    } ,
                      child: Container(height: 50,width: 100,
                        child: Text(
                          "login",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue),
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return signuppage();
                            },
                          ));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.lightBlue),
                        )),
                    TextButton(
                        onPressed: () {


                        },
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.lightBlue),
                        ))
                  ],
                )
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
class mylogindata {
  int? connection;
  int? result;
  Userdata? userdata;

  mylogindata({this.connection, this.result, this.userdata});

  mylogindata.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? iD;
  String? nAME;
  String? eMAIL;
  String? dOB;
  String? cOURSE;
  String? pASSWORD;
  String? iMAGE;

  Userdata(
      {this.iD,
        this.nAME,
        this.eMAIL,
        this.dOB,
        this.cOURSE,
        this.pASSWORD,
        this.iMAGE});

  Userdata.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAME = json['NAME'];
    eMAIL = json['EMAIL'];
    dOB = json['DOB'];
    cOURSE = json['COURSE'];
    pASSWORD = json['PASSWORD'];
    iMAGE = json['IMAGE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['NAME'] = this.nAME;
    data['EMAIL'] = this.eMAIL;
    data['DOB'] = this.dOB;
    data['COURSE'] = this.cOURSE;
    data['PASSWORD'] = this.pASSWORD;
    data['IMAGE'] = this.iMAGE;
    return data;
  }
}

