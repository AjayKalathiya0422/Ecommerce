import 'dart:convert';

import 'package:apiloginpage/homepage.dart';
import 'package:apiloginpage/productview.dart';
import 'package:apiloginpage/startpage.dart';
import 'package:apiloginpage/updatepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';

class viewproduct extends StatefulWidget {
  const viewproduct({Key? key}) : super(key: key);

  @override
  State<viewproduct> createState() => _viewproductState();
}

class _viewproductState extends State<viewproduct> {
  deletedata? dd;
  viewproductdata? prod;
  bool Isview = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewapi();
  }

  Future<void> viewapi() async {
    String userid = startpage.prefrs!.getString("iD") ?? "";
    Map productmap = {
      "loginid": userid,
    };

    var url = Uri.parse(
        'https://riyaanjiyaanpage.000webhostapp.com/apicalling/viewproduct.php');
    var response = await http.post(url, body: productmap);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var mm = jsonDecode(response.body);
    setState(() {
      prod = viewproductdata.fromJson(mm);

      if (prod!.connection == 1 && prod!.result == 1) {
        setState(() {
          Isview = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Isview
            ? Scaffold(
                backgroundColor: Colors.white,
                body: Scaffold(
                  body: SlidableAutoCloseBehavior(
                    child: GridView.builder(
                      itemCount: prod!.productdata!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, childAspectRatio: 2.5),
                      itemBuilder: (context, index) {
                        return Slidable(closeOnScroll: true,groupTag: "abc"   ,enabled: true,
                          startActionPane:
                              ActionPane(motion: StretchMotion(), children: [
                            SlidableAction(
                              onPressed: (context) {},
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              icon: Icons.share,
                              label: "Share",
                            ),
                                SlidableAction(onPressed: (context) {},autoClose: true,
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                  icon: Icons.archive,
                                  label: "Archive",
                        ),
                          ]),
                          endActionPane: ActionPane(motion: BehindMotion(), children: [
                            SlidableAction(onPressed: (context) async {

                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return updatepage(prod!.productdata![index]);
                              },));

                            },
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              icon: Icons.update_sharp,
                              label: "Update",
                            ),
                              SlidableAction(onPressed: (context) async {
                                EasyLoading.show(status: 'loading...');
                              String? idnumber = prod!.productdata![index].iD;
                              Map dele={"loginid":idnumber};
                              print("======$dele");
                                var url = Uri.parse(
                                    'https://riyaanjiyaanpage.000webhostapp.com/apicalling/deleteproduct.php');
                                var response = await http.post(url, body: dele);
                                print('Response status: ${response.statusCode}');
                                print('Response body: ${response.body}');

                                var mm = jsonDecode(response.body);
                                dd=deletedata.fromJson(mm);
                                if(dd!.connection==1){
                                  if(dd!.result==1){
                                    setState(() {
                                      viewapi();
                                    });
                                    EasyLoading.dismiss(animation: false);
                                    EasyLoading.showSuccess('Delete Success!');
                                  }
                                }
                              },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: "Delete",
                              ),
                          ]),
                          child: InkWell(onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return productview(prod!.productdata![index]);
                            },));
                          },
                            child: Card(
                              elevation: 30,
                              margin: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://riyaanjiyaanpage.000webhostapp.com/apicalling/${prod!.productdata![index].proimage}"))),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title: Text(
                                            "${prod!.productdata![index].productname}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 10),
                                                Text(
                                                  "${prod!.productdata![index].description}",
                                                  style: TextStyle(fontSize: 20),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "₹${prod!.productdata![index].productprize}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w900,
                                                      color: Colors.green),
                                                )
                                              ]),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}

class viewproductdata {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  viewproductdata({this.connection, this.result, this.productdata});

  viewproductdata.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata'] != null) {
      productdata = <Productdata>[];
      json['productdata'].forEach((v) {
        productdata!.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata != null) {
      data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdata {
  String? iD;
  String? productname;
  String? productprize;
  String? description;
  String? proimage;
  String? userid;

  Productdata(
      {this.iD,
      this.productname,
      this.productprize,
      this.description,
      this.proimage,
      this.userid});

  Productdata.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    productname = json['productname'];
    productprize = json['productprize'];
    description = json['Description'];
    proimage = json['proimage'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['productname'] = this.productname;
    data['productprize'] = this.productprize;
    data['Description'] = this.description;
    data['proimage'] = this.proimage;
    data['userid'] = this.userid;
    return data;
  }
}

class deletedata {
  int? connection;
  int? result;

  deletedata({this.connection, this.result});

  deletedata.fromJson(Map<String, dynamic> json) {
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
