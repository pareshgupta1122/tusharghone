import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tusharghone/HomeModule/screens/courseDetailsScreen.dart';
import 'package:tusharghone/HomeModule/widgets/CoursesWidget.dart';
import 'package:tusharghone/common_widgets/Bgcontainer.dart';
import 'package:tusharghone/hexColor.dart';
import 'package:tusharghone/HomeModule/providers/course_provider.dart';
import 'package:tusharghone/HomeModule/providers/quiz_provider.dart';

class ResultScreen extends StatefulWidget {
  static const routeName = '/ResultScreen';
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<Courses>(context);
    double dw = MediaQuery.of(context).size.width;
    double dh = MediaQuery.of(context).size.height;
    final tS = MediaQuery.of(context).textScaleFactor;
    final quizProvider = Provider.of<Questions>(context);
    final totalScore = ModalRoute.of(context)!.settings.arguments as int;

    num correct = totalScore / 10;

    num wrong = (quizProvider.quizQuestions.length + 1) - correct;

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
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset('assets/svgs/arrows.svg')),
                  SizedBox(width: dw * 0.1),
                  Text(
                    "Results",
                    style: TextStyle(
                        fontSize: 18 * tS, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: dw * 0.1),
              Text(
                'Score :  ${totalScore}/${10 * (quizProvider.quizQuestions.length + 1)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: dw * 0.1),
              Column(
                children: [
                  Text(
                    'QUESTION ANALYSIS',
                    style: TextStyle(color: Color(smallText)),
                  ),
                  SizedBox(height: dw * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Correct - ${correct}'),
                      Text('Wrong - ${wrong}')
                    ],
                  ),
                  SizedBox(height: dw * 0.1),
                  Container(
                      color: Color(buttoncolor),
                      child: TextButton(
                          onPressed: () {}, child: Text('VIEW SOLUTIONS',style: TextStyle(color: Colors.white)))),
                ],
              ),
              SizedBox(height: dw * 0.05),
              Text(
                'Recommended Courses',
                style: TextStyle(color: Color(smallText)),
              ),
              SizedBox(height: dw * 0.1),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  SizedBox(width: dw * 0.05),
                  ...courseProvider.getCourseByType('Paid').map(
                        (courses) => InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                CourseDetailsScreen.routeName,
                                arguments: {'id': courses.id});
                          },
                          child: CourseWidget(
                            imageUrl: courses.imageUrl,
                            title: courses.title,
                            subTitle: courses.subtitle,
                            instructor: courses.instructor,
                            courseType: courses.isEnrolled
                                ? 'Enrolled'
                                : courses.courseType,
                          ),
                        ),
                      )
                ]),
              ),
            ],
          ),
          padding: EdgeInsets.all(dw * 0.05)),
    )));
  }
}
