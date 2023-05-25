import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tusharghone/hexColor.dart';

import 'package:tusharghone/AuthModule/screens/mobileverification.dart';
import 'package:tusharghone/common_widgets/Bgcontainer.dart';



class MobileNumberScreen extends StatefulWidget {
  static const routeName = '/MobileNumber';
  const MobileNumberScreen({super.key});

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _errorMsg;

  void _validateMobileNumber(String value) {
    if (value.isEmpty) {
      setState(() {
        _errorMsg = 'Mobile number is required';
      });
    } else if (value.length != 10) {
      setState(() {
        _errorMsg = 'Invalid mobile number';
      });
    } else {
      setState(() {
        _errorMsg = null;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgContainer(
        
        padding: EdgeInsets.only(left: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 125.h, right: 229.w, bottom: 40.h),
              child: Image.asset('assets/images/mobilenumberscreen.png'),
            ),
            Text(
              'Mobile Number',
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.w),
            ),
            SizedBox(
              height: 7.h,
            ),
            Text(
              'Enter your mobile number to proceed',
              style: TextStyle(
                  fontSize: 12.w, color: Color(hexColor(smallText.toString()))),
            ),
            SizedBox(height: 56.h),
            Padding(
              padding: EdgeInsets.only(right: 24.w),
              child: TextFormField(
                
                controller: _controller,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: SvgPicture.asset('assets/svgs/Rectangle.svg'),
                  hintText: 'Enter your mobile number',
                  errorText: _errorMsg,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Mobile number is required';
                  } else if (value.length != 10) {
                    return 'Invalid mobile number';
                  }
                  return null;
                },
                onChanged: _validateMobileNumber,
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(buttoncolor)),
                height: 56.h,
                width: 312.w,
                child: TextButton(
                    onPressed: () {
                      if (_controller.text.length < 10) {
                       
                        
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text("Mobile Number must be 10 digits."),
                                actions: [
                                  TextButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        
                      }else{
                        Navigator.of(context)
                            .pushNamed(MobileVerificationScreen.routeName,arguments:{'number': int.parse(_controller.text)}
                              
                             );
                      }
                     
                    },
                    child: Text(
                      'Get Otp',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
            SizedBox(height: 52.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(
                  
                 
                  color: Colors.red,
                ),
                Text(
                  'OR',
                  style:
                      TextStyle(color: Color(smallText)),
                ),
                Divider(
                  
                  color: Colors.red,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 80.w, right: 104.w, top: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset('assets/svgs/Group.svg'),
                ],
              ),
            ),
            SizedBox(height: 95.h),
            Padding(
              padding: EdgeInsets.only(left: 3.w, right: 28.w),
              child: Text(
                'By continuing you agree to the Terms of services and Privacy policy',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.w),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
