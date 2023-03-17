import 'package:apiloginpage/addproduct.dart';
import 'package:apiloginpage/main.dart';
import 'package:apiloginpage/startpage.dart';
import 'package:apiloginpage/viewproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String? name;
  String? email;
  String? imagepath;
  int cnt = 0;
  List<Widget> list = [viewproduct(), addproduct()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = startpage.prefrs!.getString("NAME");
    email = startpage.prefrs!.getString("eMAIL");
    imagepath = startpage.prefrs!.getString("Image");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: list[cnt],
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://riyaanjiyaanpage.000webhostapp.com/apicalling/$imagepath"),
                  backgroundColor: Colors.blue,
                ),
                otherAccountsPictures: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text("1"),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text("2"),
                  )
                ],
                accountName: Text("$name", style: TextStyle(fontSize: 25)),
                accountEmail: Text(
                  "$email",
                  style: TextStyle(fontSize: 15),
                )),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  cnt = 0;
                });
              },
              leading: Icon(Icons.shopping_cart),
              title: Text(
                "View Product",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  cnt = 1;
                });
              },
              leading: Icon(Icons.shopping_basket),
              title: Text("Add Product", style: TextStyle(fontSize: 20)),
              trailing: Icon(Icons.arrow_right),
            ),
            Center(
                child: InkWell(
              onTap: () {
                startpage.prefrs!.setBool("loginstatus", false);
                EasyLoading.show(status: "Please wait");
                Future.delayed(Duration(seconds: 2))
                    .then((value) {
                  EasyLoading.showSuccess("Logout successfull");
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(
                        builder: (context) {
                          return apiloginpage();
                        },
                      ));
                });
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top * 16),
                child: Text(
                  "Logout",
                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                ),
              ),
            ))
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
