import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dicee'),
          backgroundColor: Colors.red,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  State<DicePage> createState() => _DicePateState();
}

class _DicePateState extends State<DicePage> {
  int leftDiceImage = 1;
  int rightDiceImage = 2;
  int sum = 0;
  var lst = new List<int>.filled(0,0, growable:true);
  int count = 1;

  rolldices(){
    setState(() {
      leftDiceImage = Random().nextInt(6) + 1;
      rightDiceImage = Random().nextInt(6) + 1;
      sum = leftDiceImage + rightDiceImage;
      lst.add(sum);
      print(lst);


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 16.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    rolldices();
                  },
                  child: Image.asset('images/dice$leftDiceImage.png'),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 16.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    rolldices();
                  },
                  child: Image.asset('images/dice$rightDiceImage.png'),
                ),
              ),
            ),
          ],

        ),
      ),
      bottomNavigationBar: BottomAppBar(child:Text('Stack: $lst',style: TextStyle(fontSize: 20),)),
      





    );




    
  }


}
