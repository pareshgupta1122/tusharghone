import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:tusharghone/HomeModule/screens/tabs_screen.dart';
import 'package:tusharghone/common_widgets/Bgcontainer.dart';
import 'package:tusharghone/hexColor.dart';
import 'package:tusharghone/AuthModule/screens/detailScreen2.dart';
import 'package:tusharghone/AuthModule/providers/auth_provider.dart';

class MobileVerificationScreen extends StatefulWidget {
  static const routeName = '/mobileVerfy';
  const MobileVerificationScreen({super.key});

  @override
  State<MobileVerificationScreen> createState() =>
      _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen> {
  final TextEditingController _pinController = TextEditingController();
  bool _isValidPin = false;
  bool isLoading = false;

  login(int number) async {
    try {
      if (isLoading) return;

      setState(() => isLoading = true);

      final response = await Provider.of<Users>(context, listen: false)
          .login(number.toString());
      if (response) {
  
        Navigator.of(context).pushNamed(TabsScreen.routeName);
      } else {
   
        Navigator.of(context).pushNamed(DetailScreen2.routeName,
            arguments: {'number': number});
      }
    } catch (e) {
      print(e);
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final int mobileNumber = routeArgs['number']!;
    return Scaffold(
      body: BgContainer(
        padding: EdgeInsets.only(left: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 125.h, right: 229.w, bottom: 40.h),
              child: Image.asset('assets/images/mobverify.png'),
            ),
            Text(
              'Mobile Verification',
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.w),
            ),
            SizedBox(
              height: 7.h,
            ),
            Text(
              'Enter The 6 digit code that is sent on \n +91 1122334455',
              style: TextStyle(
                  fontSize: 12.w, color: Color(hexColor(smallText.toString()))),
            ),
            SizedBox(height: 56.h),
            Padding(
              padding: EdgeInsets.only(right: 24.w),
            ),
            Padding(
              padding: EdgeInsets.only(right: 24.w),
              child: PinCodeTextField(
                keyboardType: TextInputType.number,
                controller: _pinController,
                appContext: context,
                length: 6, // set the length of the PIN code
                onChanged: (value) {
                  setState(() {
                    _isValidPin = value.length == 6; // validate the PIN code
                  });
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  selectedFillColor: Colors.grey[200],
                  selectedColor: Colors.black,
                  inactiveFillColor: Colors.grey[200],
                  inactiveColor: Colors.grey[500],
                  activeColor: Colors.black,
                ),
                onCompleted: (value) {
                  if (value.length != 6) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("PIN code must be 6 digits."),
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
                  }
                },

                textStyle: TextStyle(
                  color: Color(buttoncolor),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(buttoncolor)),
                height: 56.h,
                width: 312.w,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator(color: Colors.white))
                    : TextButton(
                        onPressed: () {
                          if (_pinController.text.length != 6) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text("PIN code must be 6 digits."),
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
                          } else {
                             login(mobileNumber);
                            // Navigator.of(context).pushNamed(
                            //     DetailScreen2.routeName,
                            //     arguments: {'number': mobileNumber});
                           }
                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ))),
            SizedBox(height: 12.h),
            Row(
              children: [
                Text(
                  'Didnt Get it?',
                  style: TextStyle(fontSize: 14.w),
                ),
                Text(
                  ' Resend',
                  style: TextStyle(color: Color(buttoncolor), fontSize: 14.w),
                ),
                Text(
                  ' in 0:15',
                  style: TextStyle(fontSize: 14.w),
                ),
              ],
            ),
            SizedBox(height: 165.h),
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
