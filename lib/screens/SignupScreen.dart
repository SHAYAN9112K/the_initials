import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_initials/screens/LoginScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final emailController = TextEditingController();
  final displayNameController = TextEditingController();
  final passwordController = TextEditingController();
  final retypePasswordController = TextEditingController();


  bool isPasswordVisible = false;
  bool isRetypePasswordVisible = false;

  final emailFocus = FocusNode();

  bool isEmailValid = false;

  Future<void> signUp() async {

    if(passwordController.text != retypePasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password and Retype Password are not same'),
        ),
      );
      return;
    }

    final supabase = Supabase.instance.client;


    final response = await supabase.auth.signUp(
      email: emailController.text,
      password: passwordController.text,
      data: {
        'displayName': displayNameController.text,

      },
    );


    print('Response: $response');

    if (response.user != null) {
      print('Login successful: ${response.user!.email}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sign up successful"),
        ),
      );
      Get.to(() =>const LoginScreen());
    } else {
      print('Sign up failed');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign up failed'),
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
              10.verticalSpace,
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Display Name',
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
                  controller: displayNameController,
                  decoration: InputDecoration(
                    hintText: 'Display Name',
                    prefix:Padding(
                      padding:  EdgeInsets.only(right: 5.w,top: 5.h),
                      child: SvgPicture.asset(
                        'assets/icons/user.svg',
                        color:Color.fromRGBO(41, 56, 91,1),
                        width: 20.w,
                        height: 16.h,
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
                ),
              ),
              10.verticalSpace,
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
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
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
              16.verticalSpace,
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Retype Password',
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
                  controller: retypePasswordController,
                  obscureText: !isRetypePasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Retype Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isRetypePasswordVisible = !isRetypePasswordVisible;
                        });
                      },
                      icon: Icon(
                        isRetypePasswordVisible
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
                      return 'Please retype your password';
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
                  signUp();
                },
                child: Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(41, 56, 91,1),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign up',
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
                    'Already Have an account ? ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Norwester',
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Get.offAll(() => LoginScreen());
                      },
                      child:  Text(' Log in',
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
