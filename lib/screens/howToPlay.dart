import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_initials/appConstants.dart';

class HowToPlay extends StatefulWidget {
  const HowToPlay({super.key});

  @override
  _HowToPlayState createState() => _HowToPlayState();
}

class _HowToPlayState extends State<HowToPlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/initials-bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    10.horizontalSpace,
                    // Text(
                    //   'How to Play',
                    //   style: kTextStyles18500PrimaryPoppins,
                    // ),
                    Text(
                      'Tips on How to Play:',
                      style: kTextStyles18500PrimaryPoppins.copyWith(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 50),
                  ],
                ),
              ),
              5.verticalSpace,
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1. **Understand the Objective:** The goal of the initials game is to guess the correct initials of the person based on the given clues. Pay attention to the clues and think about the person’s name that fits them.',
                        style: kTextStyles18500PrimaryPoppins.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        '2. **Use the Clues Wisely:** Clues provided can be related to various aspects of the person’s life, such as their profession, hobbies, or famous achievements. Use these clues to narrow down your guesses.',
                        style: kTextStyles18500PrimaryPoppins.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        '3. **Time Management:** Each round may have a time limit. Manage your time effectively to ensure you have enough time to answer as many questions as possible.',
                        style: kTextStyles18500PrimaryPoppins.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        '4. **Keep Track of Scores:** Pay attention to the scoring system. Correct answers earn points, while incorrect answers may have penalties. Keeping track of your score can help you gauge your progress.',
                        style: kTextStyles18500PrimaryPoppins.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        '5. **Have Fun:** The game is meant to be enjoyable and challenging. Don’t stress too much over individual questions and enjoy the game experience.',
                        style: kTextStyles18500PrimaryPoppins.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      20.verticalSpace,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
