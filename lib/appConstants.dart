import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

// --------------------------------- Colors ---------------------------------//

const kPrimaryColor = Color.fromRGBO(41, 56, 91,1);
const kSecondaryColor = Color.fromRGBO(212, 212, 212,1);
const kPrimaryColorDark = Color.fromRGBO(11, 32, 77,1);




// --------------------------------- Text Styles ---------------------------------//

final kTextStyles12Norwester = TextStyle(
  color: kSecondaryColor,
  fontSize: 13.sp,
  fontFamily: 'Norwester',
);

final kTextStyles14Norwester = TextStyle(
  color: kPrimaryColor,
  fontSize: 14.sp,
  fontFamily: 'Norwester',
);


final kTextStyles22Norwester = TextStyle(
  color: kPrimaryColor,
  fontSize: 22.sp,
  fontFamily: 'Norwester',
);

final kTextStyles12400WhitePoppins= GoogleFonts.poppins(
  fontSize: 12.sp,
  color: Colors.white,
  fontWeight: FontWeight.w400,
);

final kTextStyles14600WhitePoppins = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: Colors.white,
  fontWeight: FontWeight.w600,
);

final kTextStyles12600GreyPoppins = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: Colors.grey[600],
  fontWeight: FontWeight.w600,
);

final kTextStyles18500PrimaryPoppins = GoogleFonts.poppins(
  color: kPrimaryColor,
  fontSize: 18.sp,
  fontWeight: FontWeight.w500,
);




// --------------------------------- Widgets ---------------------------------//

class ProfileTiles extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  const ProfileTiles({super.key, this.onTap, this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 15.h),
        child: Row(
          children: [
            Text(
              title ?? 'Title',
              style:kTextStyles18500PrimaryPoppins),
            const Spacer(),
            SvgPicture.asset(
              'assets/icons/arrowRight.svg',
              height: 20.h,
              width: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}



// --------------------------------- Footer ---------------------------------//

class FooterSheet extends StatelessWidget {
  const FooterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(41, 56, 91,1),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        children: [
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 20.w),
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: 'Initials Scoreboard',
                style: TextStyle(
                  color: const Color.fromRGBO(73, 148, 236, 1),
                  fontSize: 10.sp,
                  fontFamily: 'Norwester',
                ),
                children: [
                  TextSpan(
                    text: '(',
                    style: TextStyle(
                      color: const Color.fromRGBO(152, 165, 166, 1),
                      fontSize: 10.sp,
                      fontFamily: 'Norwester',
                    ),
                  ),
                  TextSpan(
                    text: '@InitialsScore',
                    style: TextStyle(
                      color: const Color.fromRGBO(73, 148, 236, 1),
                      fontSize: 10.sp,
                      fontFamily: 'Norwester',
                    ),
                  ),
                  TextSpan(
                    text: ')',
                    style: TextStyle(
                      color: const Color.fromRGBO(152, 165, 166, 1),
                      fontSize: 10.sp,
                      fontFamily: 'Norwester',
                    ),
                  ),
                  TextSpan(
                    text:
                    ' is a rube created scoreboard and button bar to make it easy to keep score, add play by play commentary, and automatic button bar sounders as you use your official ',
                    style: TextStyle(
                      color: const Color.fromRGBO(152, 165, 166, 1),
                      fontSize: 10.sp,
                      fontFamily: 'Norwester',
                    ),
                  ),
                  TextSpan(
                    text: 'The Initials Game cards',
                    style: TextStyle(
                      color: const Color.fromRGBO(73, 148, 236, 1),
                      fontSize: 10.sp,
                      fontFamily: 'Norwester',
                    ),
                  ),
                  TextSpan(
                    text: '. Initials Scoreboard was created by Tim Conner of ',
                    style: TextStyle(
                      color: const Color.fromRGBO(152, 165, 166, 1),
                      fontSize: 10.sp,
                      fontFamily: 'Norwester',
                    ),
                  ),
                  TextSpan(
                    text: 'Objective Labs',
                    style: TextStyle(
                      color: const Color.fromRGBO(73, 148, 236, 1),
                      fontSize: 10.sp,
                      fontFamily: 'Norwester',
                    ),
                  ),
                  TextSpan(
                    text: '(',
                    style: TextStyle(
                      color: const Color.fromRGBO(152, 165, 166, 1),
                      fontSize: 10.sp,
                      fontFamily: 'Norwester',
                    ),
                  ),
                  TextSpan(
                    text: '@InitialsScore',
                    style: TextStyle(
                      color: const Color.fromRGBO(73, 148, 236, 1),
                      fontSize: 10.sp,
                      fontFamily: 'Norwester',
                    ),
                  ),
                  TextSpan(
                    text: ')',
                    style: TextStyle(
                      color: const Color.fromRGBO(152, 165, 166, 1),
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
                  color: const Color.fromRGBO(73, 148, 236, 1),
                  fontSize: 10.sp,
                  fontFamily: 'Norwester',
                ),
                children: [
                  TextSpan(
                    text:
                    'is a play at home card game that was created by Cory Cove of the KFAN Power Trip Morning show and is required to use this app. It is',
                    style: TextStyle(
                      color: const Color.fromRGBO(152, 165, 166, 1),
                      fontSize: 10.sp,
                      fontFamily: 'Norwester',
                    ),
                  ),
                  TextSpan(
                    text: ' available for purchase from the original creator himself',
                    style: TextStyle(
                      color: const Color.fromRGBO(73, 148, 236, 1),
                      fontSize: 10.sp,
                      fontFamily: 'Norwester',
                    ),
                  ),
                  TextSpan(
                    text: ' . This app will help make The Initials Game more fun and your contestants may even feel like they are part of the show.',
                    style: TextStyle(
                      color: const Color.fromRGBO(152, 165, 166, 1),
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
                  color: const Color.fromRGBO(73, 148, 236, 1),
                  fontSize: 10.sp,
                  fontFamily: 'Norwester',
                ),
                children: [
                  TextSpan(
                    text:
                    'has no affiliation with KFAN or Cory Cove.',
                    style: TextStyle(
                      color: const Color.fromRGBO(152, 165, 166, 1),
                      fontSize: 10.sp,
                      fontFamily: 'Norwester',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
