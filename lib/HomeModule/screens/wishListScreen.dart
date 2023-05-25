import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tusharghone/common_widgets/Bgcontainer.dart';
import 'package:tusharghone/hexColor.dart';
import 'package:tusharghone/AuthModule/providers/auth_provider.dart';
import 'package:tusharghone/HomeModule/providers/course_provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  bool selected = false;

  void toggle() {
    setState(() {
      selected = !selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<Users>(context).userdetails.courseIds;
    final courseIdS = Provider.of<Users>(context).userdetails.courseIds;

    

    final wishlistCourses =
        Provider.of<Courses>(context).fetchWishlistItems(courseIdS);

    // final wishlistItem = Provider.of<Users>(context).removeCourseId(courseIdS);

    double dh = MediaQuery.of(context).size.height;
    double dw = MediaQuery.of(context).size.width;
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: dh,
            width: dw,
            child: BgContainer(
              padding: EdgeInsets.zero,
              child: wishlistCourses.isEmpty
                  ? Center(child: Text('The Wishlist is Empty'))
                  : Column(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: dw * 0.03, vertical: dw * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child:
                                    SvgPicture.asset('assets/svgs/arrows.svg')),
                            Text(
                              'My Wishlist',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15 * curScaleFactor),
                            ),
                            TextButton(
                                onPressed: () {
                                  toggle();
                                },
                                child: wishlistCourses.isEmpty
                                    ? SizedBox.shrink()
                                    : Text(selected ? 'Cancel' : 'Select')),
                          ],
                        ),
                      ),
                      ...wishlistCourses.map((e) {
                        return selected
                            ? doSelect(
                                e.title,
                                e.enrolls,
                                e.rating.toDouble(),
                                context,
                                e.imageUrl,
                                e.isChecked,
                                e.id.toString())
                            : SizedBox(
                                height: dw * 0.3,
                                width: dw * 0.9,
                                child: Row(
                                  children: [
                                    Image.asset(e.imageUrl,
                                        height: dw * 0.2, width: dw * 0.4),
                                    SizedBox(width: dw * 0.02),
                                    Wrap(
                                      direction: Axis.vertical,
                                      children: [
                                        Container(
                                            width: dw * 0.3,
                                            child: Text(e.title,
                                                style: TextStyle(
                                                    fontSize:
                                                        7 * curScaleFactor,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.yellow),
                                            Text('${e.rating}'),
                                          ],
                                        ),
                                        Text('${e.enrolls} enrolls'),
                                        Text('999'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                                Provider.of<Users>(context,
                                                      listen: false)
                                                  .removeCourseId(courseIdS);

                                              Provider.of<Courses>(context,
                                                      listen: false)
                                                  .markWishlist(
                                                      e.id.toString());
                                            },
                                            icon: Icon(user.contains(e.id)
                                                ? Icons.bookmark
                                                : Icons.bookmark_border)),
                                        SizedBox(height: dw * 0.01),
                                        TextButton(
                                            onPressed: () {},
                                            child: Text('Buy')),
                                      ],
                                    )
                                  ],
                                ),
                              );
                      }),
                      selected
                          ? TextButton(
                              onPressed: () {
                                Provider.of<Users>(context,listen: false)
                                    .removeCourseId(courseIdS);

                                // wishlistItem;
                                Provider.of<Courses>(context, listen: false)
                                    .removeWishItem();
                              },
                              child: Text('Remove this Item'))
                          : Container(),
                    ]),
            ),
          ),
        ),
        floatingActionButton: wishlistCourses.isEmpty
            ? SizedBox.shrink()
            : Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: dw * 0.08, bottom: dw * 0.03),
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  focusColor: Colors.white,
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.only(left: dw * 0.04),
                    child: Text(
                      'Enroll Now ',
                      style: TextStyle(
                          color: Color(buttoncolor),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ));
  }

  Widget doSelect(String title, int enroll, double rating, BuildContext context,
      String url, bool isdone, String id) {
    final dw = MediaQuery.of(context).size.width;
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Column(
      children: [
        SizedBox(
          height: dw * 0.3,
          width: dw * 0.9,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Provider.of<Courses>(context, listen: false)
                      .removeWishlist(id);
                },
                child: Icon(
                    isdone ? Icons.check_box : Icons.check_box_outline_blank),
              ),
              Image.asset(url, height: dw * 0.2, width: dw * 0.4),
              SizedBox(width: dw * 0.02),
              Wrap(
                direction: Axis.vertical,
                children: [
                  Container(
                      width: dw * 0.3,
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 7 * curScaleFactor,
                            fontWeight: FontWeight.bold),
                      )),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Text('$rating'),
                    ],
                  ),
                  Text('$enroll enrolls'),
                  Text('999'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
