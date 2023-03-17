import 'package:apiloginpage/payment.dart';
import 'package:apiloginpage/viewproduct.dart';
import 'package:flutter/material.dart';

class productview extends StatefulWidget {
  Productdata productdata;

  productview(this.productdata);

  @override
  State<productview> createState() => _productviewState();
}

class _productviewState extends State<productview> {
  bool maxline = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Details",
        style: TextStyle(fontSize: 25),
      )),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  Container(
                    height: size.height * 0.5,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://riyaanjiyaanpage.000webhostapp.com/apicalling/"
                                "${widget.productdata.proimage}"))),
                  ),
                  Align(
                    child: Column(children: [
                      ListTile(
                        title: Text("${widget.productdata.productname}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("₹${widget.productdata.productprize}",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "About Product:",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    "${widget.productdata.description}",
                                    maxLines: maxline ? 4 : null,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            if (maxline) {
                                              maxline = false;
                                            } else {
                                              maxline = true;
                                            }
                                          });

                                        },
                                        child: Text(
                                            maxline ? "more..." : "Less...",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),)),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              "Product Description:",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Name:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "\t\t\t\t\t\t\t\t\t${widget.productdata.productname}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Price:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "\t\t\t\t\t\t\t\t\t\t${widget.productdata.productprize}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Desc:",
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "\t\t\t\t\t\t\t\t\t\t${widget.productdata.description}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ]),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.green.shade200),
                  child: Center(
                      child: Text(
                    "Add to Cart",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
                  width: size.width * 0.5,
                  height: size.height * 0.07,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return payment();

                  },));

                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.teal),
                  child: Center(
                      child: Text(
                    "Buy Now",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                  width: size.width * 0.5,
                  height: size.height * 0.07,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
