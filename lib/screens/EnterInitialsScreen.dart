import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:audioplayers/audioplayers.dart';

import 'GameScreen.dart';


class EnterInitialsScreen extends StatefulWidget {
  final List<String> players;
  const EnterInitialsScreen({super.key, required this.players});

  @override
  State<EnterInitialsScreen> createState() => _EnterInitialsScreenState();
}

class _EnterInitialsScreenState extends State<EnterInitialsScreen> {

  final intialController = TextEditingController();

  List<String> players = [];

  @override
  initState() {
    super.initState();
    players = widget.players;
  }

  void addPlayer() {

  }

  Future<void> playSound() async{
    List<String> sounds = [
      "pirate-coat",
      "liber",
      "legionnaire",
      "sauce",
      "paul-edwardo-lambert",
      "dwight-hawkey",
      "buffalo-sabers",
      "nobodyaskedyoukevin",
    ];
    int randomIndex = Random().nextInt(sounds.length);
    String sound = sounds[randomIndex];

    AudioPlayer audioPlayer = AudioPlayer();
    audioPlayer.play(
      AssetSource('audio/$sound.mp3'),
      volume: 2,
    );
  }

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
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'Enter the initials you have selected for this game',
                  style: TextStyle(
                    color: const Color.fromRGBO(11, 32, 77,1),
                    fontSize: 20.sp,
                    fontFamily: 'Norwester',
                  ),
                ),
                10.verticalSpace,
                SizedBox(
                  height: 40.h,
                  child: Stack(
                    children: [
                      Container(
                        width: 335.w,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255,0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      TextFormField(
                        controller: intialController,
                        decoration: InputDecoration(
                          hintText: 'Enter both initials from the card bundle you\'ve selected here',
                          hintStyle: TextStyle(
                            color: const Color.fromRGBO(212, 212, 212,1),
                            fontSize: 11.sp,
                            fontFamily: 'Norwester',
                          ),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromRGBO(11, 32, 77,1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(intialController.text.isEmpty) {
                          return;
                        }
                        Get.to(() => GameScreen(players: players,initials: intialController.text,));
                        AudioPlayer audioPlayer1 = AudioPlayer();
                        audioPlayer1.play(
                          AssetSource('audio/time-to-play.mp3'),
                          volume: 2,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(47, 93, 40,1),
                          borderRadius: BorderRadius.circular(2.r),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0,0.25),
                              offset: Offset(0,4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'ADD INITIALS',
                            style: TextStyle(
                              color: const Color.fromRGBO(255, 255, 255,1),
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                Text(
                  "(Now is the time to make sure you unmute your phone if you would like sound effects for right and wrong answers etc.)",
                  style: TextStyle(
                    color: const Color.fromRGBO(11, 32, 77,1),
                    fontSize: 12.sp,
                    fontFamily: 'Norwester',
                  ),
                ),
                20.verticalSpace,
                Expanded(
                  child: ListView.builder(
                    itemCount: players.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255,1),
                          borderRadius: BorderRadius.circular(5.r),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0,0.15),
                              offset: Offset(0,4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              players[index],
                              style: TextStyle(
                                color: const Color.fromRGBO(11, 32, 77,1),
                                fontSize: 14.sp,
                                fontFamily: 'Norwester',
                              ),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18.sp,
                                  fontFamily: 'Scoreboard',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
