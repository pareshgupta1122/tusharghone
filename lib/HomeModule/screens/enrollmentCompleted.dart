import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tusharghone/HomeModule/screens/tabs_screen.dart';
import 'package:tusharghone/hexColor.dart';
import 'package:tusharghone/HomeModule/providers/course_provider.dart';

class EnrollCompleteScreen extends StatelessWidget {
  static const routeName = '/EnrollComplete';
  const EnrollCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double dw = MediaQuery.of(context).size.width;
    double dh = MediaQuery.of(context).size.height;
    final tS = MediaQuery.of(context).textScaleFactor;

    final courseId =
        ModalRoute.of(context)!.settings.arguments as String;
    final selectedItem =
        Provider.of<Courses>(context).selectedcourse(courseId.toString());

    bool freecoursetype() {
      if (selectedItem.courseType == 'Free') {
        return true;
      } else {
        return false;
      }
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/topTabScreen', (route) => route.isFirst);
        return true;
      },
      child: Scaffold(
          body: SafeArea(
            child: SizedBox(
              height: dh,
              width: dw,
              child: Column(
                children: [
                  Stack(children: [
                    Image.asset('assets/images/Confetti.png'),
                    Column(
                      children: [
                        SizedBox(
                          height: dw * 0.7,
                        ),
                        Icon(
                          Icons.done_all_rounded,
                          color: Colors.green,
                        ),
                        SizedBox(
                          height: dw * 0.05,
                        ),
                        Text(freecoursetype()?'ENROLLMENT SUCCESS':'PAYMENT SUCCESSFUL',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18 * tS,
                            )),
                        SizedBox(
                          height: dw * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: dw * 0.09),
                          child: Text(
                              'Some text line to appreciate and motivate the user briefly in one or two lines.',
                              style: TextStyle(
                                  fontSize: 10 * tS, color: Color(smallText))),
                        ),
                      ],
                    )
                  ]),
                  SizedBox(height: dw * 0.3),
                ],
              ),
            ),
          ),
          floatingActionButton: Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: dw * 0.08, bottom: dw * 0.03),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              focusColor: Colors.white,
              onPressed: () {
                // Navigator.of(context).pushNamed(TopTabScreen.routename);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (ctx) => TabsScreen(index: 1)),
                  (route) => false,
                );
              },
              child: Padding(
                padding: EdgeInsets.only(left: dw * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(freecoursetype()?
                      'LETS GET STARTED ':'Go to Courses',
                      style: TextStyle(
                          color: Color(buttoncolor),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
