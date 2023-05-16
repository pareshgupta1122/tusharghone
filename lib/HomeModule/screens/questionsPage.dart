import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tusharghone/HomeModule/screens/resultScreen.dart';
import 'package:tusharghone/InroModule/modals/Bgcontainer.dart';
import 'package:tusharghone/InroModule/modals/hexColor.dart';
import 'package:tusharghone/providers/quiz_provider.dart';

class QuestionPage extends StatefulWidget {
  static const routeName = '/QuestionPage';
  final String quizId;
  const QuestionPage({super.key, required this.quizId});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  Quiz quiz =
      Quiz(questions: [], timer: 0, title: "", isSelected: [], userAnswers: []);

  int value = -1;
  int _currentIndex = 0;
  int _score = 0;
  String ans = "";
  List totalScore = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quiz = Provider.of<Questions>(context, listen: false)
        .selectedQuiz(widget.quizId);

    for (int i = 0; i <= quiz.questions.length; i++) {
      quiz.isSelected.add([false, false, false, false]);
    }
    for (int i = 0; i <= quiz.questions.length; i++) {
      totalScore.add(0);
    }
    for (int i = 0; i < quiz.questions.length; i++) {
      quiz.userAnswers.add("");
    }

  }

  void addAnswers() {
    for (int i = 0; i <= quiz.questions.length; i++) {
      quiz.userAnswers.add(ans);
    }
  }

  num Totalscore() {
    num sum = 0;
    for (int i = 0; i < totalScore.length; i++) {
      sum = sum + totalScore[i];
    }
    return sum;
  }

  void selected(int i, index) {
    for (int k = 0; k < 4; k++) {
      quiz.isSelected[index][k] = false;
    }
    quiz.isSelected[index][i] = true;
    setState(() {});
  }

  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    double dw = MediaQuery.of(context).size.width;
    double dh = MediaQuery.of(context).size.height;
    final tS = MediaQuery.of(context).textScaleFactor;
    final quizProvider = Provider.of<Questions>(context);
    final quiz = Provider.of<Questions>(context, listen: false)
        .selectedQuiz(widget.quizId);

    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        height: dh,
        width: dw,
        child: BgContainer(
          padding: EdgeInsets.all(dw * 0.05),
          child: quizProvider.isFinished()
              ? const ResultScreen()
              : PageView.builder(
                  controller: _pageController,
                  itemCount: quiz.questions.length,
                  itemBuilder: (BuildContext context, int index) {
                    final question = quiz.questions[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.pause_circle_outline),
                            Text(
                              quiz.timer.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    ResultScreen.routeName,
                                    arguments: Totalscore());
                              },
                              child: Text(
                                "SUBMIT",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: dw * 0.2),
                        Text(
                          'QUESTIONS -${index + 1}/${quiz.questions.length}  ',
                          style: TextStyle(color: Color(smallText)),
                        ),
                        SizedBox(height: dw * 0.04),
                        Text(
                          question['question'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: dw * 0.2),
                        Expanded(
                            child: ListView.builder(
                                itemCount: question['answers'].length,
                                itemBuilder: (context, ansIndex) {
                                  final answer = question['answers'][ansIndex];

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        selected(ansIndex, index);
                                        ans = question['answers'][ansIndex];
                                        quiz.userAnswers[index] = ans;
                                      //  addAnswers();

                                        if (question['answers'][ansIndex] ==
                                            question['answer']) {
                                          _score = question['score'];
                                        } else {
                                          _score = 0;
                                        }

                                        totalScore[index] = _score;
                                        Totalscore();
                                        print(Totalscore());
                                        print(quiz.userAnswers);
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: quiz.isSelected[index]
                                                    [ansIndex]
                                                ? [
                                                    BoxShadow(
                                                        color:
                                                            Color(buttoncolor),
                                                        blurRadius: 10,
                                                        offset: Offset(0, 0),
                                                        spreadRadius: 3),
                                                  ]
                                                : [],
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets.all(5),
                                          height: dw * 0.13,
                                          width: double.infinity,
                                          child: Row(
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      left: dw * 0.02),
                                                  height: dw * 0.07,
                                                  width: dw * 0.07,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color: Colors.grey[300]),
                                                  child: Text(
                                                    'A',
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  )),
                                              SizedBox(width: dw * 0.01),
                                              Text(
                                                answer,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )
                                            ],
                                          )),
                                    ),
                                  );
                                })),
                        SizedBox(height: dw * 0.3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            index > 0
                                ? Container(
                                    height: dw * 0.12,
                                    width: dw * 0.25,
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: TextButton(
                                        onPressed: index > 0
                                            ? () {
                                                _pageController.previousPage(
                                                    duration: Duration(
                                                        milliseconds: 250),
                                                    curve: Curves.easeInOut);
                                              }
                                            : null,
                                        child: Text(
                                          'Previous',
                                          style: TextStyle(
                                              color: Color(buttoncolor),
                                              fontWeight: FontWeight.bold),
                                        )),
                                  )
                                : Text(
                                    'Previous',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                            index < quiz.questions.length - 1
                                ? Container(
                                    height: dw * 0.12,
                                    width: dw * 0.25,
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: TextButton(
                                        style: ButtonStyle(),
                                        onPressed: () => index <
                                                quiz.questions.length - 1
                                            ? _pageController.nextPage(
                                                duration:
                                                    Duration(milliseconds: 250),
                                                curve: Curves.easeInOut)
                                            : null,
                                        child: Text(
                                          'Next',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(buttoncolor)),
                                        )))
                                : Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ],
                        ),
                      ],
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  }),
        ),
      ),
    ));
  }
}
