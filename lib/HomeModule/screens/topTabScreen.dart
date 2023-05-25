import 'package:flutter/material.dart';
import 'package:tusharghone/HomeModule/screens/conpletedCourse.dart';
import 'package:tusharghone/HomeModule/screens/myCourses.dart';
import 'package:tusharghone/common_widgets/Bgcontainer.dart';

class TopTabScreen extends StatefulWidget {
  static const routename = '/topTabScreen';
  const TopTabScreen({super.key});

  @override
  State<TopTabScreen> createState() => _TopTabScreenState();
}

class _TopTabScreenState extends State<TopTabScreen> {
  @override
  Widget build(BuildContext context) {
    return BgContainer(
      padding: EdgeInsets.zero,
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('My Courses'),
              bottom: TabBar(tabs: [
                Tab(
                  text: 'Ongoing',
                ),
                Tab(
                  text: 'Completed',
                ),
              ]),
            ),
            body: TabBarView(children: [MycoursesScreen(), CompletedCourse()]),
          )),
    );
  }
}
