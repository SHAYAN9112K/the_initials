import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_initials/screens/CreatePlayers.dart';
import 'package:the_initials/screens/SignupScreen.dart';

import 'ProfilePage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordVisible = false;


  final emailFocus = FocusNode();

  bool isEmailValid = false;

  Future<void> loginUser() async {

    try{
      final supabase = Supabase.instance.client;

      final response = await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      print('Response: $response');

      if (response.user != null) {

        final user = supabase.auth.currentUser;

        final String? email = user?.email;
        final String? displayName = user?.userMetadata?['displayName'];

        Get.to(() => CreatePlayersScreen(
          email: email,
          username: displayName,
        ));

      } else {
        print('Login failed:');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Failed'),
          ),
        );
      }
    }catch(e){
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
        ),
      );
    }

  }

  final RegExp emailRegex = RegExp(
    r'^[^@]+@[^@]+\.[^@]+$',
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               SvgPicture.asset(
                 'assets/icons/initials-logo.svg',
                 color:Color.fromRGBO(41, 56, 91,1),
                 width: 100.w,
                 height: 100.h,
               ),
              const SizedBox(height: 16.0),
               Text(
                'Nice to meet you 👋',
                style: TextStyle(
                  color: Color.fromRGBO(11, 32, 77,1),
                  fontSize: 24.sp,
                  fontFamily: 'Norwester',
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Let’s introduce yourself for explore the new experience in around you.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey,
                   fontFamily: 'Norwester',
                ),
              ),
              32.verticalSpace,
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Norwester',
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              Stack(
                children: [

                  isEmailValid && emailFocus.hasFocus
                      ?  const Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child:Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                          ),
                        )
                  : const SizedBox(),
                  SizedBox(
                    height: 60.h,
                    child: TextFormField(
                      focusNode: emailFocus,
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Email or Phone Number',
                        prefix:Padding(
                          padding:  EdgeInsets.only(right: 5.w),
                          child: Transform.scale(
                            scale: 1.2,
                            child: SvgPicture.asset(
                              'assets/icons/mail.svg',
                              color:Color.fromRGBO(41, 56, 91,1),
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide:  BorderSide(
                            color: isEmailValid && emailFocus.hasFocus
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide:  BorderSide(
                            color: isEmailValid && emailFocus.hasFocus
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide:  BorderSide(
                            color: isEmailValid && emailFocus.hasFocus
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),



                      ),
                      onChanged: (value) {
                        isEmailValid = emailRegex.hasMatch(value);
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Password',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Norwester',
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              SizedBox(
                height: 60.h,
                child: TextFormField(
                  obscureText: !isPasswordVisible,
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                    prefix:Padding(
                      padding:  EdgeInsets.only(right: 7.w),
                      child: Transform.scale(
                        scale: 1.2,
                        child: SvgPicture.asset(
                          'assets/icons/lock.svg',
                          color:Color.fromRGBO(41, 56, 91,1),
                        ),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                  },
                ),
              ),

              const SizedBox(height: 32.0),
              GestureDetector(
                onTap: () {
                  loginUser();
                },
                child: Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(41, 56, 91,1),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Norwester',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t Have an account ? ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Norwester',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() =>const SignupScreen());
                    },
                      child:  Text(' Sign Up',
                        style: TextStyle(
                        color: const Color.fromRGBO(41, 56, 91,1),
                        fontFamily: 'Norwester',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                      ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
