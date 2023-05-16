import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tusharghone/HomeModule/screens/allQuizScreen.dart';
import 'package:tusharghone/HomeModule/screens/courseDetailsScreen.dart';
import 'package:tusharghone/HomeModule/screens/startQuiz.dart';
import 'package:tusharghone/HomeModule/widgets/CoursesWidget.dart';
import 'package:tusharghone/HomeModule/widgets/quizCard.dart';
import 'package:tusharghone/InroModule/modals/Bgcontainer.dart';
import 'package:tusharghone/InroModule/modals/hexColor.dart';
import 'package:tusharghone/providers/auth_data.dart';
import 'package:tusharghone/providers/course_provider.dart';

import '../../providers/quiz_provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselController _controller = CarouselController();
  final List<String> imgList = [
    'assets/images/93.png',
    'assets/images/95.png',
    'assets/images/96.png',
  ];
  int _currentIndex = 0;

  bool isloading = false;

  fetchQuizes() {
    try {
      if (isloading) return;

      setState(() {
        isloading = true;
      });

      Provider.of<Questions>(context, listen: false).fetchQuizes();
    } catch (e) {
      print(e);
    } finally {
      if (mounted) setState(() => isloading = false);
    }
  }

  fetchCourses() {
    try {
      if (isloading) return;

      setState(() {
        isloading = true;
      });

      Provider.of<Courses>(context, listen: false).fetchCourses();
    } catch (e) {
      print(e);
    } finally {
      if (mounted) setState(() => isloading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCourses();
    fetchQuizes();
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<Courses>(context);
    final quizProvider = Provider.of<Questions>(context);
    final user = Provider.of<Users>(context);
    double dh = MediaQuery.of(context).size.height;
    double dw = MediaQuery.of(context).size.width;
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
              height: dh,
              width: dw,
              child: SingleChildScrollView(
                child: BgContainer(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: dw * 0.07),
                      Padding(
                        padding:
                            EdgeInsets.only(left: dw * 0.05, right: dw * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome,',
                                  style: TextStyle(
                                    fontSize: 12 * curScaleFactor,
                                  ),
                                ),
                                Text(
                                  user.userdetails.name,
                                  style: TextStyle(
                                      fontSize: 18 * curScaleFactor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset('assets/svgs/Search.svg'),
                                SizedBox(width: dw * 0.04),
                                SvgPicture.asset('assets/svgs/Googlee.svg'),
                                SizedBox(width: dw * 0.04),
                                SvgPicture.asset(
                                    'assets/svgs/Notification.svg'),
                              ],
                            )
                          ],
                        ),
                      ),

                      SizedBox(height: dw * 0.03),
Stack(
  children: [
    CarouselSlider(
  carouselController: _controller,
  options: CarouselOptions(
    viewportFraction: 0.9,
    height: dw * 0.6,
    autoPlay: true,
    enlargeCenterPage: true,
    onPageChanged: (index, reason) {
      setState(() {
        _currentIndex = index;
      });
    },
  ),
  items: imgList.map((item) => Container(
    child: Center(
      child: Image.asset(item, fit: BoxFit.cover, width: double.infinity),
    ),
  )).toList(),
),

    Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: DotsIndicator(
                              dotsCount: imgList.length,
                              position: _currentIndex.toDouble(),
                              decorator: DotsDecorator(
                                color: Colors.white,
                                activeColor: Color(buttoncolor),
                                size: const Size.square(7.0),
                                activeSize: const Size(20.0, 7.0),
                                spacing:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
    ),
  ],
),





                      // Image.asset('assets/images/introimage.png',
                      //     width: dw, height: dw * 0.4, fit: BoxFit.cover),
                      // SizedBox(height: dw * 0.03),
                      // Center(child: SvgPicture.asset('assets/svgs/Frame.svg')),
                       SizedBox(height: dw * 0.07),

                      Padding(
                        padding:
                            EdgeInsets.only(left: dw * 0.05, right: dw * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Continue Learning ',
                              style: TextStyle(
                                  fontSize: 16 * curScaleFactor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: dw * 0.05),
                            SizedBox(
                              height: dw * 0.2,
                              width: dw * 0.9,
                              child: Card(
                                child: Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Money Making Trading Course',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          '5/20 Modules',
                                          style: TextStyle(
                                              color: Color(smallText)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: dw * 0.05),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Color(buttoncolor)),
                                ]),
                              ),
                            ),
                            SizedBox(height: dw * 0.05),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Free Courses ',
                                  style: TextStyle(
                                      fontSize: 16 * curScaleFactor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'See All',
                                  style: TextStyle(
                                      fontSize: 12 * curScaleFactor,
                                      color: Color(buttoncolor)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: dw * 0.05),

                      isloading
                          ? Center(child: CircularProgressIndicator())
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SizedBox(width: dw * 0.05),
                                  ...courseProvider.getCourseByType('Free').map(
                                        (courses) => InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                CourseDetailsScreen.routeName,
                                                arguments: {'id': courses.id});
                                            print(user.userdetails.courseIds);
                                          },
                                          child: CourseWidget(
                                            imageUrl: courses.imageUrl,
                                            title: courses.title,
                                            subTitle: courses.subtitle,
                                            instructor: courses.instructor,
                                            courseType: user.userdetails
                                                    .enrolledCourseIds
                                                    .contains(courses.id)
                                                ? 'Enrolled'
                                                : courses.courseType,
                                          ),
                                        ),
                                      )
                                ],
                              ),
                            ),

                      Padding(
                        padding:
                            EdgeInsets.only(left: dw * 0.05, right: dw * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Paid Courses ',
                              style: TextStyle(
                                  fontSize: 16 * curScaleFactor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'See All',
                              style: TextStyle(
                                  fontSize: 12 * curScaleFactor,
                                  color: Color(buttoncolor)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: dw * 0.05),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          SizedBox(width: dw * 0.05),
                          ...courseProvider.getCourseByType('Paid').map(
                                (courses) => InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        CourseDetailsScreen.routeName,
                                        arguments: {'id': courses.id});
                                  },
                                  child: CourseWidget(
                                    imageUrl: courses.imageUrl,
                                    title: courses.title,
                                    subTitle: courses.subtitle,
                                    instructor: courses.instructor,
                                    courseType: user
                                            .userdetails.enrolledCourseIds
                                            .contains(courses.id)
                                        ? 'Enrolled'
                                        : courses.courseType,
                                  ),
                                ),
                              )
                        ]),
                      ),
                      SizedBox(height: dw * 0.05),

                      Padding(
                        padding:
                            EdgeInsets.only(left: dw * 0.05, right: dw * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Quiz',
                              style: TextStyle(
                                  fontSize: 16 * curScaleFactor,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushNamed(AllQuizScreen.routeName),
                              child: Text(
                                'See All',
                                style: TextStyle(
                                    fontSize: 12 * curScaleFactor,
                                    color: Color(buttoncolor)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: dw * 0.05),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(width: dw * 0.05),
                            ...quizProvider.quizQuestions.map((quiz) =>
                                GestureDetector(
                                    onTap: () => Navigator.of(context)
                                            .pushNamed(StartQuiz.routeName,
                                                arguments: {
                                              'id': quiz.id,
                                              'text': quiz.title
                                            }),
                                    child: QuizCard(
                                      text: quiz.title,
                                    ))),
                          ],
                        ),
                      ),

                      SizedBox(height: dw * 0.05),

                      Padding(
                        padding:
                            EdgeInsets.only(left: dw * 0.05, right: dw * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Help Videos',
                              style: TextStyle(
                                  fontSize: 16 * curScaleFactor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'See All',
                              style: TextStyle(
                                  fontSize: 12 * curScaleFactor,
                                  color: Color(buttoncolor)),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: dw * 0.05),

                      Container(
                        padding:
                            EdgeInsets.only(left: dw * 0.05, right: dw * 0.05),
                        height: dw * 0.15,
                        width: dw,
                        child: Card(
                            child: Row(
                          children: [
                            Icon(Icons.play_arrow),
                            SizedBox(width: dw * 0.02),
                            Text('How to buy a course?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        )),
                      ),

                      SizedBox(height: dw * 0.04),
                      Container(
                        padding:
                            EdgeInsets.only(left: dw * 0.05, right: dw * 0.05),
                        height: dw * 0.15,
                        width: dw,
                        child: Card(
                            child: Row(
                          children: [
                            const Icon(Icons.play_arrow),
                            SizedBox(width: dw * 0.02),
                            const Text('How to refer and Earn?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        )),
                      ),
                      SizedBox(height: dw * 0.05),

                      //               GridView(
                      // padding: EdgeInsets.all(20),
                      // children : Dummy_Data.map((e)=> GridItem(

                      //   title:e.title,

                      //      questions: e.questions, time: e.time)
                      // ).toList(),
                      // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(

                      // maxCrossAxisExtent: 200,
                      // childAspectRatio: 3/2,
                      // crossAxisSpacing: 20,
                      // mainAxisSpacing: 20,

                      // )),
                    ],
                  ),
                ),
              ))),

      //
    );
  }
}
