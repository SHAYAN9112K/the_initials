import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../appConstants.dart';
import 'CreatePlayers.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  final supaBaseInstance = Supabase.instance;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  Future<void> checkLoggedInUser() async {
    final user = supaBaseInstance.client.auth.currentUser;
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    }
    else {
      final String? email = user.email;
      final String? displayName = user.userMetadata?['displayName'];
      Get.offAll(() => CreatePlayersScreen(username: displayName, email: email));
    }

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          100.verticalSpace,
          Container(
            width: 375.w,
            height: 400.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/initials-bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animationController.value * 2 * 3.14159,
                      child: SvgPicture.asset(
                        'assets/icons/initials-logo.svg',
                        color: Colors.black,
                        width: 100.w,
                        height: 100.h,
                      ),
                    );
                  },
                ),
                15.verticalSpace,
                Text(
                  'SCOREBOARD',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 50.sp,
                      fontFamily: 'Scoreboard',
                  ),
                ),
                10.verticalSpace,
                Text.rich(
                  TextSpan(
                    text: 'It\'s time to play Initials, ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontFamily: 'Norwester',
                    ),
                    children: [
                      TextSpan(
                        text: 'not',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Norwester',
                        ),
                      ),
                      TextSpan(
                        text: ' on the Power Trip!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontFamily: 'Norwester',
                        ),
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: '  Unmute, crank the volume, and grab your ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontFamily: 'Norwester',
                    ),
                    children: [
                      TextSpan(
                        text: 'Initials Game cards',
                        style: TextStyle(
                          color: Color.fromRGBO(73, 148, 236, 1),
                          fontSize: 15.sp,
                          fontFamily: 'Norwester',
                        ),
                      ),
                      TextSpan(
                        text: '.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontFamily: 'Norwester',
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    checkLoggedInUser();
                  },
                  child: Container(
                    width: 120.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(210, 54, 48, 1),
                      borderRadius: BorderRadius.circular(2.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'AWAY WE GO!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),

          if(true)const FooterSheet(),

          if(false)Column(
            children: [
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 20.w),
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: 'Initials Scoreboard',
                    style: TextStyle(
                      color: Color.fromRGBO(73, 148, 236, 1),
                      fontSize: 10.sp,
                      fontFamily: 'Norwester',
                    ),
                    children: [
                      TextSpan(
                        text: '(',
                        style: TextStyle(
                          color: Color.fromRGBO(152, 165, 166, 1),
                          fontSize: 10.sp,
                          fontFamily: 'Norwester',
                        ),
                      ),
                      TextSpan(
                        text: '@InitialsScore',
                        style: TextStyle(
                          color: Color.fromRGBO(73, 148, 236, 1),
                          fontSize: 10.sp,
                          fontFamily: 'Norwester',
                        ),
                      ),
                      TextSpan(
                        text: ')',
                        style: TextStyle(
                          color: Color.fromRGBO(152, 165, 166, 1),
                          fontSize: 10.sp,
                          fontFamily: 'Norwester',
                        ),
                      ),
                      TextSpan(
                        text:
                        ' is a rube created scoreboard and button bar to make it easy to keep score, add play by play commentary, and automatic button bar sounders as you use your official ',
                        style: TextStyle(
                          color: Color.fromRGBO(152, 165, 166, 1),
                          fontSize: 10.sp,
                          fontFamily: 'Norwester',
                        ),
                      ),
                      TextSpan(
                        text: 'The Initials Game cards',
                        style: TextStyle(
                          color: Color.fromRGBO(73, 148, 236, 1),
                          fontSize: 10.sp,
                          fontFamily: 'Norwester',
                        ),
                      ),
                      TextSpan(
                        text: '. Initials Scoreboard was created by Tim Conner of ',
                        style: TextStyle(
                          color: Color.fromRGBO(152, 165, 166, 1),
                          fontSize: 10.sp,
                          fontFamily: 'Norwester',
                        ),
                      ),
                      TextSpan(
                        text: 'Objective Labs',
                        style: TextStyle(
                          color: Color.fromRGBO(73, 148, 236, 1),
                          fontSize: 10.sp,
                          fontFamily: 'Norwester',
                        ),
                      ),
                      TextSpan(
                        text: '(',
                        style: TextStyle(
                          color: Color.fromRGBO(152, 165, 166, 1),
                          fontSize: 10.sp,
                          fontFamily: 'Norwester',
                        ),
                      ),
                      TextSpan(
                        text: '@InitialsScore',
                        style: TextStyle(
                          color: Color.fromRGBO(73, 148, 236, 1),
                          fontSize: 10.sp,
                          fontFamily: 'Norwester',
                        ),
                      ),
                      TextSpan(
                        text: ')',
                        style: TextStyle(
                          color: Color.fromRGBO(152, 165, 166, 1),
                          fontSize: 10.sp,
                          fontFamily: 'Norwester',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              10.verticalSpace,
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 20.w),
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: 'The Initials Game',
                    style: TextStyle(
                      color: Color.fromRGBO(73, 148, 236, 1),
                      fontSize: 10.sp,
                      fontFamily: 'Norwester',
                    ),
                    children: [
                      TextSpan(
                        text:
                        'is a play at home card game that was created by Cory Cove of the KFAN Power Trip Morning show and is required to use this app. It is',
                        style: TextStyle(
                          color: Color.fromRGBO(152, 165, 166, 1),
                          fontSize: 10.sp,
                          fontFamily: 'Norwester',
                        ),
                      ),
                      TextSpan(
                        text: ' available for purchase from the original creator himself',
                        style: TextStyle(
                          color: Color.fromRGBO(73, 148, 236, 1),
                          fontSize: 10.sp,
                          fontFamily: 'Norwester',
                        ),
                      ),
                      TextSpan(
                        text: ' . This app will help make The Initials Game more fun and your contestants may even feel like they are part of the show.',
                        style: TextStyle(
                          color: Color.fromRGBO(152, 165, 166, 1),
                          fontSize: 10.sp,
                          fontFamily: 'Norwester',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              10.verticalSpace,
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 20.w),
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: 'InitialsScoreboard.com',
                    style: TextStyle(
                      color: Color.fromRGBO(73, 148, 236, 1),
                      fontSize: 10.sp,
                      fontFamily: 'Norwester',
                    ),
                    children: [
                      TextSpan(
                        text:
                        'has no affiliation with KFAN or Cory Cove.',
                        style: TextStyle(
                          color: Color.fromRGBO(152, 165, 166, 1),
                          fontSize: 10.sp,
                          fontFamily: 'Norwester',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              30.verticalSpace,
            ],
          ),

        ],
      ),
    );
  }
}
