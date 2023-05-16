import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:tusharghone/HomeModule/screens/tabs_screen.dart';
import 'package:tusharghone/InroModule/modals/hexColor.dart';

import 'package:tusharghone/InroModule/screens/introPage2.dart';
import 'package:tusharghone/InroModule/modals/Bgcontainer.dart';
import 'package:tusharghone/InroModule/screens/mobilenumberScreen.dart';
import 'package:tusharghone/providers/auth_data.dart';

class Intro1Page extends StatefulWidget {
  static const routeName = '/intro1';
  const Intro1Page({super.key});

  @override
  State<Intro1Page> createState() => _Intro1PageState();
}

class _Intro1PageState extends State<Intro1Page> {
  final LocalStorage storage = LocalStorage('tusharghone');
  autoLogin() async {
    try {
      var authProvider = Provider.of<Users>(context, listen: false);
      await storage.ready;
      final key = storage.getItem('accessToken');

      if (key != null) {
        var accessToken = json.decode(key);
        if (accessToken != null) {
          final user = await authProvider.login(accessToken['phone']);

          if (user) {
            // ignore: unnecessary_null_comparison
            if (authProvider.userdetails.phone != null) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (ctx) => TabsScreen()),
                (route) => false,
              );
            } else {
              Navigator.of(context).pushNamed(MobileNumberScreen.routeName);
            }
          } else {
            Navigator.of(context).pushNamed(MobileNumberScreen.routeName);
          }
        } else {
          Navigator.of(context).pushNamed(MobileNumberScreen.routeName);
        }
      } else {
        Navigator.of(context).pushNamed(MobileNumberScreen.routeName);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  

  @override
  void dispose() {
    super.dispose();
  }

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
                Image.asset('assets/images/introimage.png',
                    width: 260.w, height: 192.h),
                SizedBox(height: 125.h),
                Padding(
                  padding: EdgeInsets.only(left: 63.w, right: 63.w),
                  child: Text('Learn to trade \n anytime, anywhere',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontFamily: 'Montserrat', fontSize: 20.w)),
                ),
              ]),
        ),
      ),
      floatingActionButton: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 64.w),
            child: SvgPicture.asset('assets/svgs/Frame.svg'),
          ),
          SizedBox(width: 172.w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 56.h),
            child: FloatingActionButton(
              backgroundColor: Color(buttoncolor),
              onPressed: () {
                Navigator.of(context).pushNamed(Intro2Page.routeName);
              },
              child: SvgPicture.asset('assets/svgs/arrow.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
