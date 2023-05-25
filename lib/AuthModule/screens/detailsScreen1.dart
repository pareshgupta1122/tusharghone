import 'package:flutter/material.dart';
import 'package:tusharghone/hexColor.dart';
import 'package:tusharghone/AuthModule/screens/detailScreen2.dart';

import 'package:tusharghone/common_widgets/Bgcontainer.dart';

class DetailScreen1 extends StatelessWidget {
  static const routeName = '/detailsPage1';
  const DetailScreen1({super.key});

  @override
  Widget build(BuildContext context) {

    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final int mobileNumber = routeArgs['number']!;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SafeArea(
        child: BgContainer(
          padding: EdgeInsets.only(left: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Step 1 of 2'),
                SizedBox(width: width * 0.05),
              ],
            ),
            SizedBox(
              height: height * 0.06,
            ),
            Text('Welcome! \nLets Make a Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20 * curScaleFactor,
                )),
            SizedBox(height: height * 0.03),
            Text(
              'Add a photo so that other members \nknow who you are.',
              style: TextStyle(fontSize: 10 * curScaleFactor),
            ),
            SizedBox(height: height * 0.03),
            Center(child: Image.asset('assets/images/Profile.png')),
            SizedBox(height: height * 0.27),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(DetailScreen2.routeName,arguments: {'number':mobileNumber});
                },
                child: Text('Skip For Now',
                    style: TextStyle(
                      color: Color(smallText),
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            SizedBox(height: height * 0.03),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(buttoncolor)),
                height: height * 0.07,
                width: width * 0.9,
                child: TextButton(
                    onPressed: () {
                      // Navigator.of(context)
                      //     .pushNamed(MobileNumberScreen.routeName);
                    },
                    child: Text(
                      'Upload a Photo',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )))
          ]),
        ),
      ),
    );
  }
}
