import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Array1 extends StatefulWidget{
  @override
  State<Array1> createState() => Array_state();


}
class ArrayElement {
  int? value;
  double x;
  bool isMoving;
  bool is_selected;
  bool is_selected1;

  ArrayElement({this.value, required this.x,this.isMoving = false,this.is_selected = false,this.is_selected1 = false});
}

class Array_state extends State<Array1> {
  @override
  TextEditingController sizeC = TextEditingController();
  TextEditingController indexc = TextEditingController();
  TextEditingController valuec = TextEditingController();

  List<ArrayElement> array = [];
  bool arrayCreated = false;
  final double boxWidth = 70;
  final double gap = 10;
  void Created(){
    int size = int.tryParse(sizeC.text) ?? 0;
    if(size>0){
      setState(() {
        array = List.generate(size, (i)=> ArrayElement(value:null,x:i * (boxWidth + gap)));
        arrayCreated = true;
      });
    }
    sizeC.clear();
  }
  Future<void> Inserted() async{
    int? index = int.tryParse(indexc.text);
    int? value = int.tryParse(valuec.text);
    if (!array.any((e) => e.value == null)){
      showDialog(
          context: context,
        builder: (BuildContext context){
        return AlertDialog(
          title: Text("Insertion Failed"),
          content: Text("Array is full! Cannot insert new element",style: TextStyle(color: Colors.red),),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text("OK"))
          ],
        );
        }
      );
    }
    if(index!= null && value!= null &&  index>=0 && index< array.length){
      for (int i = array.length - 1; i > index; i--) {

        array[i].isMoving = true;
        setState(() {});


        array[i].value = array[i - 1].value;


        array[i].x = (i + 1) * (boxWidth + gap);
        setState(() {});
        await Future.delayed(Duration(milliseconds: 300));


        array[i].x = i * (boxWidth + gap);
        setState(() {});
        await Future.delayed(Duration(milliseconds: 300));


        array[i].isMoving = false;
        setState(() {});
        await Future.delayed(Duration(milliseconds: 100));
      }


      array[index].value = value;
      setState(() {});

      indexc.clear();
      valuec.clear();

    }

    }

     Future<void> deletion() async {
    int? index = int.tryParse(indexc.text);
    if(index != null && index >= 0 && index < array.length){
      for(int i = index; i< array.length - 1;i++){
      array[i].isMoving = true;
      setState(() {});


        array[ i ].value = array[i+1].value;

        array[i].x = (i - 1) * (boxWidth + gap);
         setState(() {});
        await Future.delayed(Duration(milliseconds: 400));

         array[i].x = i * (boxWidth + gap);
        setState(() {});
        await Future.delayed(Duration(milliseconds: 400));

         array[i].isMoving = false;
        setState(() {});
        await Future.delayed(Duration(milliseconds: 100));
      }

      array[array.length - 1].value = null;
      setState(() {});


      indexc.clear();
    }

    }

   Future<void> Reversal() async{

    int i = 0;
    int j = array.length - 1;
    while(i<j){

       array[i].isMoving = true;
      array[i].is_selected1 = true;
    array[j].isMoving = true;
    array[j].is_selected1 = true;
    setState(() {

    });
    await Future.delayed(Duration(milliseconds: 200));



    double tempX = array[i].x;
    array[i].x = array[j].x;
    array[j].x = tempX;
     setState(() {

     });

      await Future.delayed(Duration(milliseconds: 500));



        array[i].isMoving = false;
       array[i].is_selected1 = false;
    array[j].isMoving = false;
    array[j].is_selected1 = false;
       setState((){});
       await Future.delayed(Duration(milliseconds: 200));
   i++;
   j--;


    }


  }

  Future<void> Traversal () async{

  for(int i = 0;i<array.length;i++){
  array[i].isMoving = true;
  array[i].is_selected = true;
  setState((){});
  await Future.delayed(Duration(milliseconds:400));

  array[i].isMoving = false;
  array[i].is_selected = false;
  setState((){});
  await Future.delayed(Duration(milliseconds: 400)); }

    String res = array.map((e) => e.value?.toString()??"_").join(", ");
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Traversal"),
        content: Text(res),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // close dialog
            },
            child: Text("OK"),
          ),
        ],
      );
    });
  }




  Widget ArrayBoxes() {
    return Container(
      height: 180,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: array.length*(boxWidth + gap),
          child: Stack(
            children: array.asMap().entries.map((entry) {
              int index = entry.key;
              ArrayElement elem = entry.value;
              return AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                left: elem.x,
                top: 10,
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: elem.is_selected1?110:elem.is_selected?110:boxWidth,
                      height: elem.is_selected1?110:elem.is_selected?110:boxWidth,
                      decoration: BoxDecoration(
                        color: elem.is_selected1?Colors.greenAccent:elem.is_selected? Colors.pinkAccent:elem.isMoving? Colors.orange: elem.value == null
                            ? Colors.grey
                            : Colors.blue,
                        border: Border.all(color: Colors.blue.shade800),
                      ),
                      child: Center(
                        child: Text(
                          elem.value?.toString() ?? "_",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 4,),
                    Text(index.toString(),style: TextStyle(fontSize: 19,color: Colors.white),)
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Array Visualizer"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            children: [
              TextField(
                controller: sizeC,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Array size",
                  prefixText: "Size: ",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent
                    ),

                  ),


                ),

              ),
              ElevatedButton(onPressed: Created, child: Text("Create Array",style: TextStyle(color:Colors.black),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),),
            ],
          ),

          if(arrayCreated) ArrayBoxes(),

          Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton(onPressed: Inserted, child: Text("INSERTION"),),
                    SizedBox(width: 10,),
                    ElevatedButton(onPressed:deletion, child: Text("DELETION")),
                    SizedBox(width: 10,),
                    ElevatedButton(onPressed: Traversal, child: Text("TRAVERSAL")),
                    SizedBox(width: 10,),
                    ElevatedButton(onPressed: Reversal , child: Text("REVERSAL")),
                  ],
                ),
              ),
              Column(
                children: [
                  TextField(
                    controller: indexc ,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: "Index: ",
                      hintText: "Enter Index",
                    ),
                  ),
                  TextField(
                    controller: valuec ,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: "Value: ",
                      hintText: "Enter Value",
                    ),
                  )
                ],
              )
            ],
          ),


        ],
      )



    );
  }
}