import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tusharghone/HomeModule/screens/homeScreen.dart';
import 'package:tusharghone/common_widgets/Bgcontainer.dart';
import 'package:tusharghone/hexColor.dart';
import 'package:tusharghone/HomeModule/providers/course_provider.dart';

class MycoursesScreen extends StatelessWidget {
  static const routeName = '/myCourses';
  const MycoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final enrolledCourse = Provider.of<Courses>(context).enrolledCourses;

    double dh = MediaQuery.of(context).size.height;
    double dw = MediaQuery.of(context).size.width;
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/HomeScreen', (route) => route.isFirst);
        return true;

      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: dh,
            width: dw,
            child: BgContainer(
              child: Column(
                children: [
                  
                  
                  SizedBox(
                    height: dw * 0.05,
                  ),
                  ...enrolledCourse.map((course) {
                    return ListTile(
                      leading: Image.asset('assets/images/checkoutimage.png'),
                      title: Text(course.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13 * curScaleFactor)),
                      subtitle: TextButton(
                        onPressed: () {},
                        child: Text('Start Now',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Color(smallText),
                                fontWeight: FontWeight.bold,
                                fontSize: 10 * curScaleFactor)),
                      ),
                      trailing: Icon(Icons.arrow_right),
                    );
                  }),
                ],
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }
}
