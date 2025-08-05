

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   TextEditingController heightcontroller = TextEditingController();
   TextEditingController weightcontroller = TextEditingController();
  bool male = false;
  bool female = false;
  String category = "";
  String bmi = "";
  String imagePath = "";

void calculateBMI(){
  double weight = double.tryParse(weightcontroller.text)??0;
  double height = double.tryParse(heightcontroller.text)??0;
  if(weight <=0 || height<=0 || (!female && !male)){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter valid height, weight, and select gender")
        )
    );
    return;
  }
  height = height/100;
   double tbmi =  weight / (height * height);
  String gender = male ? 'male' : 'female';
  setState(() {
    bmi = tbmi.toStringAsFixed(1);
    if (tbmi < 18.5) {
      category = 'Underweight';
      imagePath = 'assets/images/underweight_$gender.jpg';
    } else if (tbmi < 24.9) {
      category = 'Normal';
      imagePath = 'assets/images/normal_$gender.jpg';
    } else if (tbmi < 29.9) {
      category = 'Overweight';
      imagePath = 'assets/images/overweight_$gender.jpg';
    } else {
      category = 'Obese';
      imagePath = 'assets/images/obese_$gender.jpg';
    }

  });

}
   void dispose() {
     heightcontroller.dispose();
     weightcontroller.dispose();
     super.dispose();
   }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(

        backgroundColor: Colors.indigoAccent,

        title: Text('Your BMI Calculator',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30)),
      ),
      body:
      Column(
        children: [
          Column(
            children: [
              Text("Gender : ",style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 40,),),
              Row(
                children: [
                  SizedBox(width: 5,),
                  ElevatedButton(onPressed: (){
                    setState(() {
                      male = true;
                      female = false;
                    });


                  },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: male ? Colors.cyan.withOpacity(0.3) : Colors.blueGrey.withOpacity(0.3),
                    ),
                    child: Text('♂ Male',style: TextStyle(fontSize: 30)),),
                  SizedBox(width: 15,),
                  ElevatedButton(onPressed: (){
                    setState(() {
                      male = false;
                      female = true;
                    });
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: female ? Colors.cyan.withOpacity(0.3) : Colors.blueGrey.withOpacity(0.3),
                      ),
                      child: Text('♀ Female',style: TextStyle(fontSize: 30)))
                ],
              )
            ],
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("For Your Reference 💡: BMI < 18.5 → Underweight,18.5 ≤ BMI < 25 → Normal,25 ≤ BMI < 30 → Overweight,30 ≤ BMI < 35 → Obese Class ")
              ));
            },
              child: Image.network("https://cdn-icons-png.flaticon.com/512/7565/7565048.png",height: 55,)),
          SizedBox(height: 30,),
          Center(
            child: Container(

              width: 300,
              height: 500,
              child: Column(
                children: [
                  TextField(
                    controller: heightcontroller,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),

                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Colors.white70
                      )
                    ),
                        hintText: 'Height',
                    suffixText: 'CM',
                    prefixText: '📏'
                  ),

                  ),
                  TextField(
                    controller: weightcontroller,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Colors.white70
                            )
                        ),
                      hintText: 'Weight ',
                      suffixText: 'KG',
                      prefixText: '⚖️'

                    ),
                  ),
                  SizedBox(height:25 ,),
                  ElevatedButton(onPressed:
                      calculateBMI,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent
                      ),
                      child: Text("Calculate BMI",style: TextStyle(color: Colors.black),)),
                     TextButton(onPressed: (){
                       setState(() {
                         heightcontroller.clear();
                         weightcontroller.clear();
                         male = false;
                         female = false;
                         bmi = '';
                         imagePath = '';
                         category = '';
                       });


                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text("Reset Successful",style: TextStyle(color:Colors.black),),
                         backgroundColor: Colors.cyanAccent,)
                       );

                     }, child: Text("Reset")),
                  if(bmi.isNotEmpty)
                    Column(
                      children: [
                        Card(
                          elevation: 3,
                            color:Colors.blue.withOpacity(0.3),
                            child: Text("Your BMI : $bmi",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),)),
                        SizedBox(height: 5,),
                        Card(
                            color:Colors.blue.withOpacity(0.3),
                            elevation: 3,
                            child: Text("Category: $category",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
                        SizedBox(height: 10,),
                        Image.asset(imagePath,height: 150,)
                      ],
                    )



                ],
              ),
            ),
          ),
        ],
      )




    );
  }
}
