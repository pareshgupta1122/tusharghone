import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tusharghone/common_widgets/Bgcontainer.dart';

class AllQuizScreen extends StatefulWidget {
  static const routeName = '/allQuizScreen';
  const AllQuizScreen({super.key});

  @override
  State<AllQuizScreen> createState() => _AllQuizScreenState();
}

class _AllQuizScreenState extends State<AllQuizScreen> {
  @override
  Widget build(BuildContext context) {
    double dw = MediaQuery.of(context).size.width;
    double dh = MediaQuery.of(context).size.height;
    final tS = MediaQuery.of(context).textScaleFactor;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: dh,
          width: dw,
          child: BgContainer(
              padding: EdgeInsets.all(dw*0.05),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset('assets/svgs/arrows.svg')),
                      SizedBox(width: dw * 0.1),
                     
                     Text("All Quizes"
                      ,
                        style: TextStyle(
                            fontSize: 18 * tS,
                            fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),

                 ...{1,2,3,4,5,6,7}.map((e) => Padding(

                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)

                    ),
                    
                     child: ListTile(
                      onTap: () => (){},
                      
                          leading: Container(child: SvgPicture.asset('assets/svgs/quiz.svg')),
                          title: Text(
                            " Quiz  $e",
                            style: TextStyle(
                                fontSize: 12 * tS, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('10 Questions . 5 Minutes',style: TextStyle(
                                fontSize: 9 * tS, )),
                          trailing: Icon(Icons.done_rounded,color: Colors.green,),
                        ),
                   ),
                 ), )  
                  
                  


                ],
              )),
        ),
      ),
    );
  }
}
