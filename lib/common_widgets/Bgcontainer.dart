import 'package:flutter/material.dart';

class BgContainer extends StatelessWidget {
  final Widget child;
  EdgeInsetsGeometry padding;
  BgContainer({
    Key? key,
    required this.child,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

     double dw = MediaQuery.of(context).size.width;
   
    return Container(
    
      width: dw,
      child: child,
      padding: padding,
      decoration: BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
                        colors: [
                          

        const Color(0xffFBFFF4),
        const Color(0xff98CCEC),
      ])),
    );
  }
}
