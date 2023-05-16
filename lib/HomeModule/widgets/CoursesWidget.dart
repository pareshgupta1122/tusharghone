import 'package:flutter/material.dart';

class CourseWidget extends StatelessWidget {
  
  final String imageUrl;

  final String title;

  final String subTitle;

  final String instructor;

  final String courseType;

  const CourseWidget({super.key, required this.imageUrl, required this.title, required this.subTitle, required this.instructor, required this.courseType});

  @override
  Widget build(BuildContext context) {
    double dh = MediaQuery.of(context).size.height;
    double dw = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
    
    return Container(
      height: dw*0.7,
     
     
      margin: EdgeInsets.only(right: dw * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              imageUrl,
              height: dw * 0.35,
              width: dw * 0.75,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: dw * 0.75,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: dw * 0.03,
              vertical: dw * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10 * tS,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: dw * 0.02),
                Text(
                  subTitle,
                  style: TextStyle(fontSize: 8 * tS),
                ),
                SizedBox(height: dw * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      instructor,
                      style: TextStyle(fontSize: 8 * tS),
                    ),
                    Text(
                      courseType,
                      style: TextStyle(
                        fontSize: 12 * tS,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // items: cardList.map((card) {
    //   return Builder(
    //     builder: (BuildContext context) {
  }
}
