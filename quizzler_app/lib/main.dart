import 'package:flutter/material.dart';
import 'package:quizzler_app/answer.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  //-------------------------
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;

  void _questionAnswered(bool answerScore) {
    setState(() {
      // answer was selected
      answerWasSelected = true;
      // check if answer was correct
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }
      // adding to the score tracker on top
      _scoreTracker.add(
        answerScore
            ? Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : Icon(
                Icons.clear,
                color: Colors.red,
              ),
      );
      //when the quiz ends
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerSelected = false;
    });
    // what happens at the end of the quiz
    if (_questionIndex >= _questions.length) {
      _resetQuiz();
    }
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      endOfQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                _questions[_questionIndex]['question'].toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        ...(_questions[_questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) => Answer(
                  answerText: answer['answerText'].toString(),
                  answerColor: answerWasSelected
                      ? answer['score'] == true
                          ? Colors.green
                          : Colors.red
                      : Colors.white10,
                  answerTap: () {
                    // if answer was already selected then nothing happens onTap
                    if (answerWasSelected) {
                      return;
                    }
                    //answer is being selected
                    _questionAnswered(answer['score'] == true ? true : false);
                  },
                )),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.blueGrey,
              child: Text(
                endOfQuiz ? 'Restart Quiz' : 'Next Question',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                if (!answerWasSelected) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Please select an answer before going to the next question',style: TextStyle(color: Colors.green),),
                  ));
                  return;
                }
                _nextQuestion();
              },
            ),
          ),
        ),
        Row(
          children: [
            if (_scoreTracker.length == 0) SizedBox(height: 25.0),
            if (_scoreTracker.length > 0) ..._scoreTracker
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Text(
            '${_totalScore.toString()}/${_questions.length}',
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        if(answerWasSelected && !endOfQuiz)
          Container(
            height: 25,
            color: correctAnswerSelected ? Colors.green : Colors.red,
            child: Center(
              child: Text(
                correctAnswerSelected
                    ? 'Well done, you got it right!'
                    : 'Wrong :/',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        if (endOfQuiz)
          Container(
            height: 25,
            color: Colors.black,
            child: Center(
              child: Text(
                _totalScore > 1
                    ? 'Congratulations! Your final score is: $_totalScore'
                    : 'Your final score is: $_totalScore. Better luck next time!',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: _totalScore > 1 ? Colors.green : Colors.red,
                ),
              ),
            ),
          ),

      ],
    );
  }
}

final _questions = const [
  {
    'question': 'You can lead a cow down stairs but not up stairs.',
    'answers': [
      {'answerText': 'True', 'score': false},
      {'answerText': 'False', 'score': true},
    ]
  },
  {
    'question': 'Approximately one quarter of human bones are in the feet.',
    'answers': [
      {'answerText': 'True', 'score': true},
      {'answerText': 'False', 'score': false},
    ]
  },
  {
    'question': 'A slug\'s blood is green.',
    'answers': [
      {'answerText': 'True', 'score': true},
      {'answerText': 'False', 'score': false},
    ]
  },
];

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
