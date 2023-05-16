import 'package:flutter/material.dart';
import 'package:tusharghone/InroModule/modals/Bgcontainer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
     double dh = MediaQuery.of(context).size.height;
    double dw = MediaQuery.of(context).size.width;
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: dh,
          width: dw,
          child: BgContainer(
            child: Column(
              children: [
                Text('MY Profile'),
              ],
            ),
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}