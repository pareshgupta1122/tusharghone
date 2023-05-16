import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  String title;
  String questions;
  String time;
  GridItem({
    Key? key,
    required this.title,
    required this.questions,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dw = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: dw * 0.1,
        width: dw * 0.1,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Icon(Icons.alarm),
            Text(
              title,
            ),
            Row(
              children: [
                Text(
                  questions,
                ),
                Text(
                  time,
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    ;
  }
}
