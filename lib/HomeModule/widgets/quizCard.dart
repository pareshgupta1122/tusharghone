import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final String text;
  const QuizCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    double dw = MediaQuery.of(context).size.width;
    double dh = MediaQuery.of(context).size.height;
    return Container(
      height: dw * 0.28,
      width: dw * 0.4,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(dw * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.alarm),
              Text(
                text,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('10 Qs'),
                  Text(
                    '5 Min',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
