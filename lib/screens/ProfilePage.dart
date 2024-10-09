import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_initials/screens/FAQsScreen.dart';
import 'package:the_initials/screens/GameHistory.dart';
import 'package:the_initials/screens/LoginScreen.dart';

import '../appConstants.dart';
import 'CreatePlayers.dart';
import 'PrivacyPolicies.dart';
import 'howToPlay.dart';


class ProfilePage extends StatefulWidget {
  final String? username;
  final String? email;
  const ProfilePage({super.key, this.username, this.email});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 26.w, vertical: 15.h),
          child: Column(
            children: [
              Row(
                children: [
                  5.horizontalSpace,
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          kPrimaryColor,
                          kPrimaryColor.withOpacity(0.5),
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 34.r,
                      backgroundColor: Colors.transparent,
                      child: CircleAvatar(
                        radius: 32.5.r,
                        foregroundImage: const AssetImage("assets/icons/user3d.jpg"),
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.username != null ? widget.username! : 'Loading...',
                        style: kTextStyles22Norwester,
                      ),
                      Text(
                        widget.email != null ? widget.email! : 'Loading...',
                        style: kTextStyles12Norwester,
                      ),

                    ],
                  ),
                ],
              ),



              10.verticalSpace,

              Divider(
                thickness: 1,
                height: 30.h,
                color: Colors.grey[300],
              ),
              5.verticalSpace,
              Row(
                children: [
                  Text(
                    'My Account',
                    style: kTextStyles12600GreyPoppins,
                  ),
                ],
              ),

              ProfileTiles(
                title: 'Game History',
                onTap: () {
                  Get.to(() => const GameHistoryScreen());
                },
              ),




              Divider(
                thickness: 1,
                height: 30.h,
                color: Colors.grey[300],
              ),
              5.verticalSpace,
              Row(
                children: [
                  Text(
                    'Information',
                    style: kTextStyles12600GreyPoppins,
                  ),
                ],
              ),
              10.verticalSpace,
              ProfileTiles(
                title: 'How to Play',
                onTap: () {
                  Get.to(() => const HowToPlay());
                },
              ),
              ProfileTiles(
                title: 'FAQs',
                onTap: () {
                  Get.to(() => const FAQsScreen());
                },
              ),
              ProfileTiles(
                title: 'Privacy Policy',
                onTap: () {
                  Get.to(() => const PrivacyPolicy());
                },
              ),







              const Spacer(),

              GestureDetector(
                onTap: () {
                  Supabase.instance.client.auth.signOut();
                  Get.offAll(() => const LoginScreen());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(5.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0,0.25),
                        offset: Offset(0,4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/Logout.svg'),
                      10.horizontalSpace,
                      Text(
                        'Logout',
                        style: kTextStyles14600WhitePoppins,
                      ),
                    ],
                  ),
                ),
              ),
              40.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
