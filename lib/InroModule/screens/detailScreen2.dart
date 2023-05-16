import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tusharghone/HomeModule/screens/tabs_screen.dart';
import 'package:tusharghone/InroModule/modals/Bgcontainer.dart';
import 'package:tusharghone/InroModule/modals/hexColor.dart';
import 'package:tusharghone/providers/auth_data.dart';


class DetailScreen2 extends StatefulWidget {
  static const routeName = '/detailScreen2';
  const DetailScreen2({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailScreen2> createState() => _DetailScreen2State();
}

class _DetailScreen2State extends State<DetailScreen2> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  DateTime? _selectedBirthDate;
  String? _selectedGender;

  bool isLoading = false;
  register(
      int phone, String name, String dob, String gender, String email) async {
    try {
      if (isLoading) return;

      setState(() => isLoading = true);

      final response = await Provider.of<Users>(context, listen: false)
          .register(phone.toString(), name, email, dob, gender);
      if (response) {
        
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (ctx) => TabsScreen()),
          (route) => false,
        );
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
    final mobileNumber = routeArgs['number'];
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: height,
        width: width,
        child: BgContainer(
          padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: width * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: SvgPicture.asset('assets/svgs/arrows.svg')),
                  Text('Step 2 of 2'),
                ],
              ),
              SizedBox(
                height: width * 0.2,
              ),
              Image.asset('assets/images/userdetail.png'),
              SizedBox(
                height: width * 0.15,
              ),
              Text(
                'Please Enter the details below to continue',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 11 * curScaleFactor),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _namecontroller,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        hintText: 'Enter your name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      // onSaved: (value) {
                      //   _editing_user = User(
                      //       name: value!,
                      //       email: _editing_user.email,
                      //       dateTime: _editing_user.dateTime,
                      //       id: null,
                      //       gender: _editing_user.gender);
                      // },
                    ),

                    TextFormField(
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        hintText: 'Enter your email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),

                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Birthdate',
                        hintText: 'Enter your birthdate',
                      ),
                      keyboardType: TextInputType.datetime,
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          setState(() {
                            _selectedBirthDate = date;
                          });
                        }
                      },
                      controller: TextEditingController(
                        text: _selectedBirthDate != null
                            ? DateFormat('yyyy-MM-dd')
                                .format(_selectedBirthDate!)
                            : null,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your birthdate';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: width * 0.1),

                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select your gender';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        labelStyle: TextStyle(
                            color: Colors.black, fontSize: 16 * curScaleFactor),
                        fillColor: Color(fillColor),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'Male',
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Text('Male'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Female',
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Text('Female'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Other',
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Text('Other'),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Add your form fields here
                  ],
                ),
              ),
              SizedBox(height: width * 0.2),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(buttoncolor)),
                  height: height * 0.07,
                  width: width * 0.9,
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              register(
                                  mobileNumber!.toInt(),
                                  _namecontroller.text,
                                  _selectedBirthDate.toString(),
                                  _selectedGender!,
                                  _emailcontroller.text);

                             

                              // User user = User(
                              //     name: _namecontroller.text,
                              //     email: _emailcontroller.text,
                              //     dob: _selectedBirthDate!,
                              //     gender: _selectedGender!,
                              //     phone: mobileNumber!.toString());

                              // Provider.of<Users>(context, listen: false)
                              //     .addUser(user);

                              // Navigator.pushAndRemoveUntil(
                              //   context,
                              //   MaterialPageRoute(builder: (ctx) => TabsScreen()),
                              //   (route) => false,
                              // );
                            }
                          },
                          child: Text(
                            'Continue',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )))
            ],
          ),
        ),
      )),
    );
  }
}
