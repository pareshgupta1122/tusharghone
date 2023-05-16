import 'package:flutter/material.dart';
import 'package:tusharghone/InroModule/modals/Bgcontainer.dart';

class CompletedCourse extends StatelessWidget {
  const CompletedCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return BgContainer(padding: EdgeInsets.zero,
    child: Text('Completed Courses'));
  }
}
