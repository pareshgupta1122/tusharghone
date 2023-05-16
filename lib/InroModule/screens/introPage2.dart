import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tusharghone/InroModule/modals/hexColor.dart';

import 'package:tusharghone/InroModule/screens/mobilenumberScreen.dart';
import 'package:tusharghone/InroModule/modals/Bgcontainer.dart';



class Intro2Page extends StatefulWidget {
  static const routeName = '/Intro2';
  const Intro2Page({super.key});

  @override
  State<Intro2Page> createState() => _Intro2PageState();
}

class _Intro2PageState extends State<Intro2Page> {
  @override
  Widget build(BuildContext context) {
     double dw = MediaQuery.of(context).size.width;
    double dh = MediaQuery.of(context).size.height;

    return Scaffold(

      body: SizedBox(
        height: dh,
        width: dw,
        child: BgContainer(
          padding: EdgeInsets.zero,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 210.h),
                Image.asset('assets/images/introimage.png',
                    width: 260.w, height: 192.h),
                SizedBox(height: 54.h),
                SvgPicture.asset('assets/svgs/Frame.svg'),
                SizedBox(height: 111.h),
                Padding(
                  padding: EdgeInsets.only(left: 63.w, right: 63.w),
                  child: Text('Learn to trade \n anytime, anywhere',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.w)),
                ),
                SizedBox(height: 49.h),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(buttoncolor)),
                    height: 56.h,
                    width: 312.w,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(MobileNumberScreen.routeName);
                        },
                        child: Text(
                          'Start Learning',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )))
              ]),
        ),
      ),
    );
  }
}
