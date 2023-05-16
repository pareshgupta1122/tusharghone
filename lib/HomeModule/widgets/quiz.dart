import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
     double dw = MediaQuery.of(context).size.width;
    double dh = MediaQuery.of(context).size.height;
    final tS = MediaQuery.of(context).textScaleFactor;
    return  ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: SvgPicture.asset('assets/svgs/quiz.svg'),
          title: Text(
            " Quiz $index",
            style: TextStyle(fontSize: 12 * tS, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.done_rounded),
          onTap: () {
            // Handle tap on the list tile
          },
        );
      },
    );
  }
}