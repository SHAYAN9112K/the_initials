import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_initials/appConstants.dart';

import 'EnterInitialsScreen.dart';
import 'ProfilePage.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePlayersScreen extends StatefulWidget {
  final String? username;
  final String? email;
  const CreatePlayersScreen({super.key, this.username, this.email});

  @override
  State<CreatePlayersScreen> createState() => _CreatePlayersScreenState();
}

class _CreatePlayersScreenState extends State<CreatePlayersScreen> {

  final playerController = TextEditingController();

  final supaBaseInstance = Supabase.instance;

  List<String> players = [];

  void addPlayer() {
    if(playerController.text.isEmpty) {
      return;
    }
    setState(() {
      players.add(playerController.text);
      playerController.clear();
    });
    playSound();
    print(players);
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
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoggedInUser();
  }


  Future<void> checkLoggedInUser() async {
    final user = supaBaseInstance.client.auth.currentUser;
    if (user == null) {

    }
    else {
      final String? email = user.email;
      final String? displayName = user.userMetadata?['displayName'];
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome, ${widget.username}! 👋',
                      style: kTextStyles14Norwester,
                    ),
                    const Spacer(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Get.to(() => ProfilePage(
                          username: widget.username,
                          email: widget.email,
                        ));
                      },
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: Colors.grey[300],
                        foregroundImage: const AssetImage("assets/icons/user3d.jpg"),
                      ),
                    ),
                  ],
                ),
                5.verticalSpace,
                Text(
                  'Give your players some names',
                  style: kTextStyles22Norwester,
                ),
                20.verticalSpace,
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
                        controller: playerController,
                        decoration: InputDecoration(
                          hintText: 'Enter player names like Greasy, Tommy, etc. here',
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(212, 212, 212,1),
                            fontSize: 12.sp,
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
                        addPlayer();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        height: 45.h,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(41, 56, 91,1),
                          borderRadius: BorderRadius.circular(2.r),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0,0.25),
                              offset: const Offset(0,4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'ADD PLAYER +',
                            style: kTextStyles12400WhitePoppins,
                          ),
                        ),
                      ),
                    ),
                    5.horizontalSpace,
                    if(players.isNotEmpty)GestureDetector(
                      onTap: () {
                            Get.to(() => EnterInitialsScreen(
                              players: players,
                            ));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        height: 45.h,
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
                            'DONE ADDING PLAYERS',
                            style: kTextStyles12400WhitePoppins,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                                color: Color.fromRGBO(11, 32, 77,1),
                                fontSize: 14.sp,
                                fontFamily: 'Norwester',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  players.removeAt(index);
                                });
                              },
                              child: const Icon(
                                CupertinoIcons.delete,
                                color: Colors.red,
                              ),
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
