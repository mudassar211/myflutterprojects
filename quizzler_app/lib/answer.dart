import 'package:flutter/material.dart';

class Answer extends StatelessWidget {

  final String answerText;
  final Color answerColor;
  final VoidCallback  answerTap;

  Answer({ required this.answerText, required this.answerColor, required this.answerTap});


  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: FlatButton(
          textColor: Colors.white,
          color: answerColor,
          child: Text(
            answerText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          onPressed: answerTap,
        ),
      ),
    );
  }
}
