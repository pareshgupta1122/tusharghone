import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tusharghone/HomeModule/screens/allQuizScreen.dart';
import 'package:tusharghone/HomeModule/screens/courseDetailsScreen.dart';
import 'package:tusharghone/HomeModule/screens/enrollNowScreen.dart';
import 'package:tusharghone/HomeModule/screens/enrollmentCompleted.dart';
import 'package:tusharghone/HomeModule/screens/homeScreen.dart';
import 'package:tusharghone/HomeModule/screens/myCourses.dart';
import 'package:tusharghone/HomeModule/screens/resultScreen.dart';
import 'package:tusharghone/HomeModule/screens/startQuiz.dart';
import 'package:tusharghone/HomeModule/screens/tabs_screen.dart';
import 'package:tusharghone/HomeModule/screens/topTabScreen.dart';
import 'package:tusharghone/AuthModule/screens/detailScreen2.dart';
import 'package:tusharghone/AuthModule/screens/detailsScreen1.dart';
import 'package:tusharghone/AuthModule/screens/intro1page.dart';
import 'package:tusharghone/AuthModule/screens/introPage2.dart';
import 'package:tusharghone/AuthModule/screens/mobilenumberScreen.dart';
import 'package:tusharghone/AuthModule/screens/mobileverification.dart';
import 'package:tusharghone/AuthModule/providers/auth_provider.dart';
import 'package:tusharghone/HomeModule/providers/course_provider.dart';
import 'package:tusharghone/HomeModule/providers/quiz_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) =>
       MultiProvider(
        providers: [
           ChangeNotifierProvider(
            create: (context) => Users(),
          ),
          ChangeNotifierProvider(create: (context)=>Courses()),
           ChangeNotifierProvider(create: (context) =>Questions()),
        ],
        
         
           child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              fontFamily: 'Montserrat',
              colorScheme: ColorScheme.light(),
              useMaterial3: true,
            ),
            home: Intro1Page(),
            routes: {
              Intro1Page.routeName:(ctx)=>Intro1Page(),
              Intro2Page.routeName: (ctx) => Intro2Page(),
              MobileNumberScreen.routeName:(context) => MobileNumberScreen(),
              MobileVerificationScreen.routeName:(context) => MobileVerificationScreen(),
              DetailScreen1.routeName:(context) => DetailScreen1(),
              DetailScreen2.routeName:(context) => DetailScreen2(),
              HomeScreen.routeName:(context) => HomeScreen(),
              TabsScreen.routeName:(context) => TabsScreen(),
              CourseDetailsScreen.routeName:(context) => CourseDetailsScreen(),
              EnrollNowScreen.routeName:(context)=>EnrollNowScreen(),
              EnrollCompleteScreen.routeName:(context) => EnrollCompleteScreen(),
              MycoursesScreen.routeName:(context) => MycoursesScreen(),
              TopTabScreen.routename:(context) => TopTabScreen(),
              AllQuizScreen.routeName:(context) => AllQuizScreen(),
              StartQuiz.routeName:(context) => StartQuiz(),

              ResultScreen.routeName:(context) => ResultScreen()
         
            },
               ),
         
       ),
      designSize: const Size(360,800),
    );
  }
}



 