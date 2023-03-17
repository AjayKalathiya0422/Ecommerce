import 'package:apiloginpage/homepage.dart';
import 'package:apiloginpage/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';


class startpage extends StatefulWidget {static bool loginstatus=false;
  static SharedPreferences? prefrs;

static void easyload() {
  EasyLoading.instance.userInteractions = false;
  EasyLoading.instance.backgroundColor = Colors.green[900];
  EasyLoading.instance.textColor = Colors.white;
  EasyLoading.instance.indicatorColor = Colors.white;
  EasyLoading.instance.indicatorSize = 40;
  EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
  EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.dualRing;
  EasyLoading.instance.animationDuration = Duration(seconds: 1);
}

  @override
  State<startpage> createState() => _startpageState();
}

class _startpageState extends State<startpage> {
  bool logindata=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sherpref();
  }

  Future<void> sherpref() async {
    startpage.prefrs = await SharedPreferences.getInstance();
    setState(() {
      logindata = startpage.prefrs!.getBool("loginstatus")??false;
    });
    Future.delayed(Duration(seconds: 5)
    ).then((value) {
      if(logindata){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return homepage();
        },));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return apiloginpage();
        },));
      }
    } );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(child: Lottie.asset("images/lootti.json"))),
    );
  }


}
