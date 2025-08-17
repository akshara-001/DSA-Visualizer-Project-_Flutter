import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class LinkedList1 extends StatefulWidget {
  @override
  State<LinkedList1> createState() => _LinkedState();
}

class Node {
  int value;
  Node? next;
  double rotation;
  Node({required this.value, this.next,this.rotation = 0});
}

enum SlideDirection { none, fromLeft, fromRight }

class _LinkedState extends State<LinkedList1> {
  Node? highlightednode;
  bool beg = false;
  bool end = false;
  int indexTrav = -1;
  bool atindex = false;
  TextEditingController valuec = TextEditingController();
  TextEditingController indexC = TextEditingController();
  Node? head;
  List<Node> NodesList = [];
  String logicText = "LinkedList operations will be shown here";
  int highlightedIndex = -1;
  int showArrowIndex = -1;
  SlideDirection slideDirection = SlideDirection.none;

  void refreshNodesList() {
    NodesList = [];
    Node? current = head;
    while (current != null) {
      NodesList.add(current);
      current = current.next;
    }
  }

  Future<void> insertAtBeginning(int value) async {
    setState(() {
      logicText = "Inserting $value at beginning";
      highlightedIndex = 0;
      slideDirection = SlideDirection.fromLeft;
    });

    Node newNode = Node(value: value);
    newNode.next = head;
    head = newNode;
    refreshNodesList();

    setState(() {});
    await Future.delayed(Duration(milliseconds: 500));

    highlightedIndex = -1;
    slideDirection = SlideDirection.none;
    showArrowIndex = 0; // show arrow after insertion
    setState(() {
      logicText = "Node $value inserted at beginning!";
    });
    valuec.clear();
    indexC.clear();

  }

  Future<void> insertAtEnd(int value) async {
    setState(() {
      logicText = "Inserting $value at end";
      slideDirection = SlideDirection.fromRight;
    });

    Node newNode = Node(value: value);

    if (head == null) {
      head = newNode;
      highlightedIndex = 0;
    } else {
      Node current = head!;
      int index = 0;
      while (current.next != null) {
        current = current.next!;
        index++;
      }
      current.next = newNode;
      highlightedIndex = index + 1;
    }

    refreshNodesList();
    setState(() {});
    await Future.delayed(Duration(milliseconds: 500));

    highlightedIndex = -1;
    slideDirection = SlideDirection.none;
    showArrowIndex = NodesList.length - 2; // show arrow for previous node
    setState(() {
      logicText = "Node $value inserted at end!";
    });
    valuec.clear();
    indexC.clear();
  }

  Future<void> insertAtIndex(int value, int position) async {
    setState(() {
      logicText = "Inserting $value at index $position";
    });

    Node newNode = Node(value: value);

    if (position <= 0 || head == null) {
      newNode.next = head;
      head = newNode;
      highlightedIndex = 0;
      showArrowIndex = -1; // no arrow before first node
    } else {
      Node current = head!;
      int index = 0;
      while (index < position - 1 && current.next != null) {
        current = current.next!;
        index++;
      }
      newNode.next = current.next;
      current.next = newNode;
      highlightedIndex = index + 1;
      showArrowIndex = index; // arrow from previous node
    }

    refreshNodesList();
    setState(() {});

    await Future.delayed(Duration(milliseconds: 500));

    highlightedIndex = -1;
    slideDirection = SlideDirection.none;

    setState(() {
      logicText = "Node $value inserted at index $position!";
    });
    indexC.clear();
    valuec.clear();
  }
  Future<void> delAtBeg() async{
    if(head == null) {
      setState(() {
        logicText = "List is empty , nothing to delete";
      });
      return;
    }
    setState(() {
      logicText = "Deleting node at beginning";
      highlightedIndex = 0;
    });
    await Future.delayed(Duration(milliseconds: 500));
    head = head!.next;
    refreshNodesList();
    setState(() {
      highlightedIndex = -1;
      logicText = "First node deleted!";
    });
  }
  Future<void> delAtEnd() async{
    if (head == null) {
      setState(() {
        logicText = "List is empty, nothing to delete!";
      });
      return;
    }
    if(head!.next == null){
      setState(() {
        logicText = "Deleting only node";
        highlightedIndex = 0;
      });
      await Future.delayed(Duration(milliseconds: 500));
      head = null;
    }
    else {
      Node current = head!;
      int index = 0;
      while(current.next!.next != null){
        current = current.next!;
        index++;
      }
      setState(() {
        logicText = "Deleting node at end";
        highlightedIndex = index + 1;
      });
      await Future.delayed(Duration(milliseconds: 500));
      current.next = null;
    }
    refreshNodesList();
    setState(() {
      highlightedIndex = -1;
      logicText = "Last node deleted!";
    });
    }
  Future<void> deleteAtIndex(int position) async {
    if (head == null) {
      setState(() {
        logicText = "List is empty, nothing to delete!";
      });
      return;
    }

    if (position <= 0) {
      return delAtBeg();
    }

    Node current = head!;
    int index = 0;
    while (index < position - 1 && current.next != null) {
      current = current.next!;
      index++;
    }

    if (current.next == null) {
      setState(() {
        logicText = "Index out of range!";
      });
      return;
    }

    setState(() {
      logicText = "Deleting node at index $position";
      highlightedIndex = position;
    });
    await Future.delayed(Duration(milliseconds: 500));

    current.next = current.next!.next; // unlink node

    refreshNodesList();
    setState(() {
      highlightedIndex = -1;
      logicText = "Node at index $position deleted!";
    });
    indexC.clear();
  }
Future<void> Traversal() async{
    String res = "";
    if(head == null){
      setState(() {
        logicText = "List is Empty";
      });
    }
    for(int i = 0;i<NodesList.length;i++){

      setState(()  {
indexTrav = i;

      });
      await Future.delayed(Duration(milliseconds: 600));

    }
    setState(() {
      indexTrav = -1; // reset after traversal
    });
    res = NodesList.map((e) => e.value.toString()??"_").join("-> ");
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
  Future<void> reversal() async {
    if (head == null) {
      setState(() {
        logicText = "List is empty, nothing to reverse!";
      });
      return;
    }

    setState(() {
      logicText = "Reversing the list...";
    });


    refreshNodesList();
    final animOrder = List<Node>.from(NodesList);

    Node? prev;
    Node? current = head;
    Node? next;
    int step = 0;


    while (current != null) {

      if (!mounted) return;
      setState(() {
        highlightedIndex = step;
      });
      await Future.delayed(const Duration(milliseconds: 500));


      if (step < animOrder.length - 1) {
        if (!mounted) return;
        setState(() {
          animOrder[step].rotation += pi;
        });
        await Future.delayed(const Duration(milliseconds: 500));
      }


      next = current.next;
      current.next = prev;
      prev = current;
      current = next;

      step++;
    }


    head = prev;
    refreshNodesList();

    for (final n in NodesList) {
      n.rotation = 0;
    }


    if (!mounted) return;
    setState(() {
      highlightedIndex = -1;
      logicText = "List reversed successfully!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LinkedList Visualizer"),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 10),
            TextField(
              controller: valuec,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter the value",
                prefixText: "Value: ",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              logicText,
              style: TextStyle(color: Colors.yellow, fontSize: 16),
            ),
            SizedBox(height: 20),
            if (NodesList.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // START pointer
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pinkAccent,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'START',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(Icons.arrow_forward, color: Colors.red, size: 30),
                    SizedBox(width: 10),
                    // Nodes as train coaches
                    for (int i = 0; i < NodesList.length; i++) ...[
                      Transform.translate(
                        offset: highlightedIndex == i
                            ? (slideDirection == SlideDirection.fromLeft
                            ? Offset(-50, 0)
                            : Offset(50, 0))
                            : Offset(0, 0),
                        child: Row(
                          children: [
                            // Node (coach)
                            AnimatedContainer(duration: Duration(milliseconds: 500),
                              width: indexTrav == i?90:50,
                              height: indexTrav == i?100:60,
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: highlightedIndex == i?Colors.red.withOpacity(0.9): indexTrav == i?Colors.greenAccent:Colors.blue,
                                border: Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "${NodesList[i].value}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 400),
                              width: indexTrav == i?90:50,
                              height: indexTrav == i?100:60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(width: 10),
                            // Arrow
                            if (i < NodesList.length - 1 )
                              AnimatedRotation(
                                  turns: NodesList[i].rotation / (2 * pi),
                                  duration: Duration(milliseconds: 500),
                                  child: Icon(Icons.arrow_forward, color: Colors.red, size: 30)),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    beg = true;
                    atindex = false;
                    end = false;

                  },
                  child: Text(
                    "At Beginning",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    elevation: 7,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    beg = false;
                    atindex = true;
                    end = false;


                  },
                  child: Text(
                    "At an Index",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    elevation: 7,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    beg = false;
                    atindex = false;
                    end = true;

                  },
                  child: Text(
                    "At End",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    elevation: 7,
                  ),
                ),
              ],
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(onPressed: (){

                    int pos = int.tryParse(indexC.text) ?? 0;
                    beg == true ? delAtBeg(): atindex == true ? deleteAtIndex(pos) : delAtEnd();
                    setState(() {
                      beg = false;
                      end = false;
                      atindex = false;
                    });
                  }, child: Text("Deletion",style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.blueGrey
                  ),),
                  SizedBox(width: 10,),
                  ElevatedButton(onPressed: (){
                    int value = int.tryParse(valuec.text) ?? 0;
                    int pos = int.tryParse(indexC.text) ?? 0;
                    beg == true ? insertAtBeginning(value): atindex == true ? insertAtIndex(value, pos) : insertAtEnd(value);
                    setState(() {
                      beg = false;
                      end = false;
                      atindex = false;
                    });

                  }, child: Text("Insertion",style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey
                    ),),
                  SizedBox(width: 10,),
                  ElevatedButton(onPressed: Traversal, child: Text("Traversal",style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey
                    ),),
                  SizedBox(width: 10,),
                  ElevatedButton(onPressed: reversal, child: Text("Reversal",style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey
                    ),),

                ],
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: indexC,
              decoration: InputDecoration(
                hintText: "Give Index",
                prefixText: "Index: ",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
