import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tusharghone/HomeModule/screens/enrollNowScreen.dart';
import 'package:tusharghone/HomeModule/screens/enrollmentCompleted.dart';

import 'package:tusharghone/common_widgets/Bgcontainer.dart';
import 'package:tusharghone/hexColor.dart';
import 'package:tusharghone/AuthModule/providers/auth_provider.dart';
import 'package:tusharghone/HomeModule/providers/course_provider.dart';

class CourseDetailsScreen extends StatefulWidget {
  static const routeName = '/CourseDetails';

  CourseDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  bool isloading = false;

  wishList(String courseId, bool value) {
    try {
      if (isloading) return;

      setState(() {
        isloading = true;
      });

      Provider.of<Users>(context, listen: false).wishlist(courseId, value);
    } catch (e) {
      print(e);
    } finally {
      if (mounted) setState(() => isloading = false);
    }
  }

  enrolledCourse(String courseId, bool value) {
    try {
      if (isloading) return;

      setState(() {
        isloading = true;
      });

      Provider.of<Users>(context, listen: false)
          .enrolledCourses(courseId, value);
    } catch (e) {
      print(e);
    } finally {
      if (mounted) setState(() => isloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context).userdetails;

    final courseId =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final selectedItem =
        Provider.of<Courses>(context).selectedcourse(courseId['id'].toString());
    double dw = MediaQuery.of(context).size.width;
    double dh = MediaQuery.of(context).size.height;
    final tS = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
        body: SafeArea(
            child: SizedBox(
          height: dh,
          width: dw,
          child: SingleChildScrollView(
            child: BgContainer(
              padding: EdgeInsets.symmetric(horizontal: dw * 0.05),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: dw * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset('assets/svgs/arrows.svg')),
                        IconButton(
                          icon: Icon(user.courseIds.contains(selectedItem.id)
                              ? Icons.bookmark
                              : Icons.bookmark_border),
                          onPressed: () {
                            Provider.of<Courses>(context, listen: false)
                                .markWishlist(selectedItem.id.toString());

                            wishList(selectedItem.id.toString(),
                                selectedItem.isMarked);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: dw * 0.05),
                    Row(
                      children: [
                        Text(
                          selectedItem.instructor,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: dw * 0.02),
                        Image.asset(selectedItem.instructorImage),
                      ],
                    ),
                    SizedBox(height: dw * 0.05),
                    Text(
                      selectedItem.title,
                      style: TextStyle(
                        fontSize: 20 * tS,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: dw * 0.05),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        Text('${selectedItem.rating}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: dw * 0.1),
                        Text('${selectedItem.enrolls}+ enrolls',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: dw * 0.1),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                const Color(0xffFBFFF4),
                                const Color(0xff98CCEC),
                              ]),
                              border: Border.all(width: 2, color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          height: dw * 0.08,
                          width: dw * 0.23,
                          child: user.enrolledCourseIds.contains(selectedItem.id)
                              ? Text('Enrolled',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold))
                              : Text(selectedItem.courseType,
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    SizedBox(height: dw * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.book_online_sharp),
                            Text(
                              selectedItem.courseLevel,
                              style: TextStyle(
                                  fontSize: 10 * tS,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.crop_square),
                            Text(
                              '${selectedItem.modules} Modules',
                              style: TextStyle(
                                  fontSize: 10 * tS,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.punch_clock),
                            Text(
                              '${selectedItem.hours} Hours',
                              style: TextStyle(
                                  fontSize: 10 * tS,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: dw * 0.1),
                    Text(
                      'Course HighLights',
                      style: TextStyle(
                        fontSize: 14 * tS,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(dw * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...selectedItem.highlights.map((highlights) {
                            return Text(
                              '\u2022   $highlights',
                              style: TextStyle(fontSize: 12 * tS),
                            );
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: dw * 0.1),
                    Text(
                      'About Course',
                      style: TextStyle(
                        fontSize: 14 * tS,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: dw * 0.05),
                    Text(
                      selectedItem.aboutcourse,
                      style: TextStyle(fontSize: 12 * tS),
                    ),
                    SizedBox(height: dw * 0.1),
                    Text(
                      'Curriculum',
                      style: TextStyle(
                        fontSize: 14 * tS,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: dw * 0.05),
                    Padding(
                      padding: EdgeInsets.all(dw * 0.03),
                      child: Column(
                        children: [
                          ...selectedItem.chapters.map((e) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: dw * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            e['title'],
                                            style: TextStyle(
                                                fontSize: 12 * tS,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: dw * 0.22),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...e['lesson'].map((lessons) {
                                        return Text(
                                          '\u2022  $lessons',
                                          style: TextStyle(fontSize: 10 * tS),
                                        );
                                      })
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                          SizedBox(height: dw * 0.03),
                          Text('See More',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(height: dw * 0.1),
                    Text(
                      'Requirements',
                      style: TextStyle(
                        fontSize: 14 * tS,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: dw * 0.05),
                    Column(
                      children: [
                        ...selectedItem.requirements.map((e) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    e['imageText'],
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: dw * 0.05),
                                  Text(e['item']),
                                ],
                              ),
                              SizedBox(height: dw * 0.03),
                            ],
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: dw * 0.1),
                    Text(
                      'About Instructor',
                      style: TextStyle(
                        fontSize: 14 * tS,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: dw * 0.05),
                    SizedBox(
                      height: dw * 0.32,
                      width: dw * 0.9,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: dw * 0.026, vertical: dw * 0.05),
                          child: Row(children: [
                            Image.asset(
                              selectedItem.cardImage,
                              height: dw * 0.2,
                              width: dw * 0.2,
                            ),
                            SizedBox(width: dw * 0.05),
                            Column(
                              children: [
                                Text(
                                  selectedItem.instructor,
                                  style: TextStyle(
                                      fontSize: 13 * tS,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: dw * 0.015),
                                Text(
                                  'SEBI Registered Advisor',
                                  style: TextStyle(fontSize: 10 * tS),
                                ),
                                SizedBox(height: dw * 0.015),
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/svgs/twitter.svg'),
                                    SizedBox(
                                      width: dw * 0.04,
                                    ),
                                    SvgPicture.asset(
                                        'assets/svgs/linkedin.svg'),
                                    SizedBox(
                                      width: dw * 0.04,
                                    ),
                                    SvgPicture.asset('assets/svgs/facebook.svg',
                                        color: Color(buttoncolor)),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: dw * 0.05),
                            Icon(Icons.arrow_forward_ios,
                                color: Color(buttoncolor)),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(height: dw * 0.1),
                    Text(
                      'Tags',
                      style: TextStyle(
                        fontSize: 14 * tS,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: dw * 0.05),
                    Wrap(children: [
                      ...selectedItem.tags.map(
                        (tag) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(buttoncolor),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(dw * 0.02),
                              child: Text(
                                tag,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 7 * tS,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(height: dw * 0.1),
                    Text(
                      'Reviews',
                      style: TextStyle(
                        fontSize: 14 * tS,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: dw * 0.05),
                    ...selectedItem.reviews.map((review) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(review['name'],
                                style: TextStyle(
                                  fontSize: 13 * tS,
                                  fontWeight: FontWeight.bold,
                                )),
                            Row(children: [
                              BuildRating(review['stars']),
                              SizedBox(width: dw * 0.02),
                              Text(review['time']),
                            ]),
                            Text(review['description']),
                            SizedBox(height: dw * 0.05),
                          ]);
                    }),
                    SizedBox(height: dw * 0.05),
                    Text('See more Reviews ',
                        style: TextStyle(
                          fontSize: 13 * tS,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: dw * 0.3),
                    SizedBox(height: dw * 0.1),
                  ]),
            ),
          ),
        )),
        floatingActionButton: user.enrolledCourseIds.contains(selectedItem.id)
            ? SizedBox.shrink()
            : Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: dw * 0.08, bottom: dw * 0.03),
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  focusColor: Colors.white,
                  onPressed: () {
                    if (selectedItem.courseType == 'Free') {

                      Provider.of<Courses>(context, listen: false)
                          .isEnrolled(selectedItem.id.toString());
                      enrolledCourse(selectedItem.id, selectedItem.isEnrolled);


                      Navigator.of(context).pushNamed(
                          EnrollCompleteScreen.routeName,
                          arguments:  selectedItem.id);

                     

                    } else {

                     
                      Navigator.of(context).pushNamed(EnrollNowScreen.routeName,
                          arguments:selectedItem.id);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: dw * 0.04),
                    child: Row(
                      children: [
                        Text(
                          'Enroll Now ',
                          style: TextStyle(
                              color: Color(buttoncolor),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: dw * 0.4),
                        Icon(Icons.arrow_forward_ios,
                            color: Color(buttoncolor)),
                      ],
                    ),
                  ),
                ),
              ));
  }
}

//for rating stars

Widget BuildRating(int rating) {
  List<Widget> stars = [];

  for (int i = 0; i < rating; i++) {
    stars.add(Container(
      margin: EdgeInsets.only(right: 5),
      child: Icon(Icons.star, color: Colors.yellow),
    ));
  }
  return Row(children: [
    ...stars.map((stars) {
      return stars;
    })
  ]);
}
