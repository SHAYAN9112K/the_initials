import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_initials/appConstants.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

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
                    Text(
                      'FAQs',
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
                      _buildFAQ(
                        'What is the objective of the initials game?',
                        'The objective of the initials game is to guess the initials of a person based on provided clues. Each clue helps narrow down the possibilities to identify the person correctly.',
                      ),
                      10.verticalSpace,
                      _buildFAQ(
                        'How do I score points?',
                        'Points are scored by correctly guessing the initials based on the clues provided. Each correct answer earns points, while incorrect answers may result in penalties or no points.',
                      ),
                      10.verticalSpace,
                      _buildFAQ(
                        'Can I change the settings of the game?',
                        'Yes, you can customize certain settings of the game. These include adjusting the time limits, selecting difficulty levels, and configuring other game options to suit your preferences.',
                      ),
                      10.verticalSpace,
                      _buildFAQ(
                        'Where can I find more information about the game?',
                        'More information about the game can be found on the official website or by accessing the help section within the app. You can also contact support for additional assistance.',
                      ),
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

  Widget _buildFAQ(String question, String answer) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: kTextStyles18500PrimaryPoppins.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            answer,
            style: kTextStyles18500PrimaryPoppins.copyWith(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
