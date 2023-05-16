import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tusharghone/InroModule/modals/Bgcontainer.dart';
import 'package:tusharghone/providers/course_provider.dart';

class MyCommunityScreen extends StatefulWidget {
  const MyCommunityScreen({super.key});

  @override
  State<MyCommunityScreen> createState() => _MyCommunityScreenState();
}

class _MyCommunityScreenState extends State<MyCommunityScreen> {
  bool selected = false;

  void toggle() {
    setState(() {
      selected = !selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final coursesSel = Provider.of<Courses>(context);

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
            child: Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: dw * 0.03, vertical: dw * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('My Wishlist'),
                    
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
