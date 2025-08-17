

import 'package:first_new/Array.dart';
import 'package:first_new/LinkedList.dart';
import 'package:first_new/splash.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF121212),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: Splash(),

    );
  }
}

class MyHomePage extends StatefulWidget {






  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool first = false;
  bool second  = false;
  bool third = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds:1),()
    {
      setState(() {
        first = true;
      });

      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          first = false;
          second = true;
        });

      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          second = false;
          third = true;
        });
      });
      });
    });
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        backgroundColor: Colors.black,

        title: Text('DSA Visualizer',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30)),
      ),
      body:
         Center(
           child: Container(
             width: double.infinity,

            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.3,1.0],

                  colors: [

                Color(0xfface0f9),
                Colors.white,
              ])
            ),
             child: Stack(
               children: [

                 Positioned(
                   top: 435,
                     left: 50,
                     child: Image.asset("assets/images/cropped.png",height: 300,)),
                 if(first)
                      Positioned(
                        top:345,
                          right: 100,

                          child: Image.asset("assets/images/img1.png",height: 100,)),
                          if(second)
                          Positioned(
                            top:345,
                              left: 165,
                              child: Image.asset("assets/images/img2.png",height:100,)),
             if(third )...[


                 Positioned(
                   left: 135,
                   top: 100,
                   child: ElevatedButton(onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Array1()));
                   }, child: Text("Array",style: TextStyle(fontSize: 30,color: Colors.black),),
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.white,
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(0)
                   ),
                       elevation: 8),),
                 ),

                 Positioned(
                   left: 120,
                   top: 160,
                   child: ElevatedButton(

                     onPressed: (){ Navigator.push(context,MaterialPageRoute(builder: (context) => LinkedList1()));},

                     child: Text("Linkedlist",style: TextStyle(fontSize: 30,color: Colors.white)),
                   style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(0)
                   ),
                     elevation: 8
                   ),
                   ),
                 )

               ],
    ]
             ),
           ),
         )
    );
  }
}
