
import 'dart:async';

import 'package:first_new/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget{
  @override
  State<Splash> createState() => _SplashState();

}

class _SplashState extends State<Splash> {
bool logo = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        logo = true;
      });
    });
    Future.delayed(Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }




  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
       width: double.infinity,
       color: Colors.white,

         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [ AnimatedContainer(duration: Duration(seconds:4),
           height : logo?400:100,
           child: Image.asset("assets/images/4799889.png"),),
             if(logo)Text("DSAEase",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),)],

         ),

     ),
   );
  }
}
