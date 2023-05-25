import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tusharghone/HomeModule/screens/questionsPage.dart';
import 'package:tusharghone/common_widgets/Bgcontainer.dart';
import '../../hexColor.dart';

class StartQuiz extends StatefulWidget {
  static const routeName = '/StartQuiz';
  const StartQuiz({super.key});

  @override
  State<StartQuiz> createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  @override
  Widget build(BuildContext context) {
    double dw = MediaQuery.of(context).size.width;
    double dh = MediaQuery.of(context).size.height;
    final tS = MediaQuery.of(context).textScaleFactor;
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String quizId = arguments['id'];
    final String quizTitle = arguments['text'];
    ;
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
              height: dh,
              width: dw,
              child: BgContainer(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {      Navigator.of(context).pop();
                              },
                              child:
                                  SvgPicture.asset('assets/svgs/arrows.svg')),
                          SizedBox(width: dw * 0.1),
                          Text(
                            quizTitle,
                            style: TextStyle(
                                fontSize: 18 * tS, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: dw * 0.2),
                      Image.asset("assets/images/bigquiz.png"),
                      SizedBox(height: dw * 0.2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'INSTRUCTIONS',
                            style: TextStyle(color: Colors.blue),
                          ),
                          Text(
                            '\u2022 You have 5 minutes for this quiz.\n\n \u2022This quiz contains 10 questions for 20 marks.\n \n\u2022Each question has 4 options. You have to select one correct option.',
                            style: TextStyle(),
                          )
                        ],
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(dw * 0.05)),
            ),
            floatingActionButton: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: dw * 0.08, bottom: dw * 0.03),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                focusColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QuestionPage( quizId: quizId)));
                },
                child: Padding(
                  padding: EdgeInsets.only(left: dw * 0.04),
                  child: Row(
                    children: [
                      Text(
                        'Start Quiz ',
                        style: TextStyle(
                            color: Color(buttoncolor),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: dw * 0.4),
                      Icon(Icons.arrow_forward_ios, color: Color(buttoncolor)),
                    ],
                  ),
                ),
              ),
            )));
  }
}
