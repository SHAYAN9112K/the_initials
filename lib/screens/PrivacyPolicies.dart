import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_initials/appConstants.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

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
                      'Privacy Policy',
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
                        '1. **Introduction:** Our privacy policy explains how we collect, use, disclose, and safeguard your information when you use our app. Please read this policy carefully.',
                        style: kTextStyles18500PrimaryPoppins.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        '2. **Information Collection:** We may collect information about you in a variety of ways. The information we may collect includes personal data, such as your name and email address, and usage data, such as how you interact with our app.',
                        style: kTextStyles18500PrimaryPoppins.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        '3. **Use of Information:** We use the information we collect to provide, maintain, and improve our services, communicate with you, and ensure the security of our app.',
                        style: kTextStyles18500PrimaryPoppins.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        '4. **Disclosure of Information:** We may share information about you in the following circumstances: with your consent, to comply with legal obligations, or with service providers who assist us in operating our app.',
                        style: kTextStyles18500PrimaryPoppins.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        '5. **Security:** We take reasonable measures to protect your information from unauthorized access, use, or disclosure. However, no security measures are perfect or impenetrable.',
                        style: kTextStyles18500PrimaryPoppins.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        '6. **Changes to This Policy:** We may update our privacy policy from time to time. We will notify you of any changes by posting the new policy on this page.',
                        style: kTextStyles18500PrimaryPoppins.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        '7. **Contact Us:** If you have any questions about this privacy policy, please contact us at [your contact information].',
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
