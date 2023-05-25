import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tusharghone/HomeModule/screens/enrollmentCompleted.dart';
import 'package:tusharghone/common_widgets/Bgcontainer.dart';
import 'package:tusharghone/hexColor.dart';
import 'package:tusharghone/AuthModule/providers/auth_provider.dart';
import 'package:tusharghone/HomeModule/providers/course_provider.dart';

class EnrollNowScreen extends StatefulWidget {
  static const routeName = '/EnrollScreen';
  const EnrollNowScreen({super.key});

  @override
  State<EnrollNowScreen> createState() => _EnrollNowScreenState();
}

class _EnrollNowScreenState extends State<EnrollNowScreen> {
  bool isdone = false;
  bool isloading = false;

  void toggle() {
    setState(() {
      isdone = !isdone;
    });
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
    final courseId = ModalRoute.of(context)!.settings.arguments as String;
    final checkoutList =
        Provider.of<Courses>(context).selectedcourse(courseId.toString());

    double gst = (18 * checkoutList.prize!.toInt()) / 100;
    double total() {
      if (isdone) {
        return checkoutList.prize!.toDouble() + gst - checkoutList.waletMoney;
      } else {
        return checkoutList.prize!.toDouble() + gst;
      }
    }

    double dw = MediaQuery.of(context).size.width;
    double dh = MediaQuery.of(context).size.height;
    final tS = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: dh,
            width: dw,
            child: BgContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset('assets/svgs/arrows.svg')),
                    SizedBox(height: dw * 0.05),
                    Text(
                      'Cart Items',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/images/checkoutimage.png',
                                height: dw * 0.2, width: dw * 0.4),
                            SizedBox(width: dw * 0.02),
                            Wrap(
                              direction: Axis.vertical,
                              children: [
                                Container(
                                    width: dw * 0.3,
                                    child: Text(checkoutList.title,
                                        style: TextStyle(
                                            fontSize: 7 * tS,
                                            fontWeight: FontWeight.bold))),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.yellow),
                                    Text('${checkoutList.rating}'),
                                  ],
                                ),
                                Text('${checkoutList.enrolls} enrolls'),
                                Text('\u20b9${checkoutList.prize}'),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                ),
                                Text('Remove'),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.bookmark_border,
                                ),
                                Text('wishList'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: dw * 0.05),
                        Row(
                          children: [
                            SvgPicture.asset('assets/svgs/discount.svg'),
                            SizedBox(width: dw * 0.03),
                            Column(
                              children: [
                                Text(
                                  'Offer available ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13 * tS),
                                ),
                                Text(
                                  'Add promocode ',
                                  style: TextStyle(fontSize: 10 * tS),
                                ),
                              ],
                            ),
                            SizedBox(width: dw * 0.33),
                            Icon(Icons.arrow_right_sharp),
                          ],
                        ),
                        SizedBox(height: dw * 0.05),
                        Row(
                          children: [
                            Icon(Icons.wallet),
                            SizedBox(width: dw * 0.03),
                            Text(
                                'Use Wallet : \u20b9${checkoutList.waletMoney}'),
                            SizedBox(width: dw * 0.33),
                            InkWell(
                              onTap: toggle,
                              child: Icon(isdone
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: dw * 0.25),
                    Column(
                      children: [
                        Text(
                          'Order details',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Items total '),
                            Text('\u20b9${checkoutList.prize}')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(' Total GST (18%)'),
                            Text('\u20b9${gst}')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(' Wallet Used'),
                            Text(isdone ? '-${checkoutList.waletMoney}' : '0')
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ' To pay',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\u20b9' + total().toStringAsFixed(2),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: dw * 0.1),
                    Text(
                      'By completing your purchase you agree to these Terms of services.',
                      style:
                          TextStyle(color: Color(smallText), fontSize: 10 * tS),
                    ),
                    SizedBox(height: dw * 0.25),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                    vertical: dw * 0.05, horizontal: dw * 0.05)),
          ),
        ),
        floatingActionButton: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: dw * 0.08, bottom: dw * 0.03),
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            focusColor: Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.of(context).pushNamed(
                EnrollCompleteScreen.routeName,

                arguments: checkoutList.id
              );

              Provider.of<Courses>(context, listen: false)
                  .isEnrolled(checkoutList.id.toString());
              enrolledCourse(courseId.toString(), checkoutList.isEnrolled);
            },
            child: Padding(
              padding: EdgeInsets.only(left: dw * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Total :',
                        style: TextStyle(
                            color: Color(buttoncolor),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        total().toStringAsFixed(2),
                        style: TextStyle(
                            color: Color(buttoncolor),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'CHECKOUT',
                        style: TextStyle(
                            color: Color(buttoncolor),
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Color(buttoncolor)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
