import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Services.dart';
import '../appConstants.dart';

class GameScreen extends StatefulWidget {
  final List<String> players;
  final String initials;
  const GameScreen({super.key, required this.players, required this.initials});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  final myScrollController = ScrollController();
  final AudioPlayer audioPlayer1 = AudioPlayer();

  Color wrongBoxColor = const Color.fromRGBO(223, 223, 223, 1);
  Color wrongTextColor = const Color.fromRGBO(160, 160, 160, 1);

  bool isClue = true;
  bool showWrongRight = false;
  bool isWinnerState = false;
  int clueIndex = 1;
  int itemCount = 1;
  int tieBreakerIndex = 0;
  int totalPlayerScore = -1;
  List<Map<String, dynamic>> stateHistory = [];

  String welcomeMessage =
      """The Power Trip Morning Show plays The Initials Game every Friday and it works like this.I have 12 items, they can be people, places, things, phrases, whatever but they share the same initials.Each item will have 6 clues. I start reading clues, as soon as you know who or what I'm describing,you yell out your name.Your name is your buzzer. You have to pronounce it correctly.If you get it right, you get a point. If you get it wrong, you are out for just that item.And away we go with the initials INIT!""";
  String displayMessage = "";

  List<String> players = [];
  List<Map<String, dynamic>> topPlayers = [];
  List<int> wrongIndexes = [];
  List<Map<String, dynamic>> playersWithScores = [];


  @override
  void initState() {
    super.initState();
    displayMessage = welcomeMessage;
    players = widget.players;
    for (int i = 0; i < players.length; i++) {
      playersWithScores.add({
        "playerID": i,
        "playerName": players[i],
        "score": 0,
        "wrongCount": 0,
        "playerStreak": 0,
        "wrongStreak": 0,
      });
    }
    initializeAnimation();
  }


  Widget _commentBox(dynamic currentPlayer) {
    bool isWinner = false;
    bool isTie = false;
    int winnerId = -1;
    int highestPlayerId = -1;
    bool isEarlyWinner = false;


    int totalItems = 12; // Adjust based on the total number of items/questions
    int processedItems = 6; // Update this with the actual count of processed items
    int remainingItems = totalItems - processedItems;

// Calculate the highest score
    int playerwithHighestScore = playersWithScores.fold(
        0,
            (max, player) => max > player["score"] ? max : player["score"]
    );

    highestPlayerId = playersWithScores
        .firstWhere((player) => player["score"] == playerwithHighestScore)["playerID"];

// Check if any player's maximum possible score can surpass the highest score
    bool canOthersSurpass = playersWithScores.any((player) {
      // Skip the current highest scorer
      if (player["playerID"] == highestPlayerId) return false;
      // Calculate the maximum achievable score for this player
      int maxPossibleScore = player["score"] + remainingItems;
      return maxPossibleScore > playerwithHighestScore;
    });

// Set isEarlyWinner if no other player can surpass the highest score
    if (!canOthersSurpass) {
      isEarlyWinner = true;
    }





    if (topPlayers.length == 1) {
      isWinner = true;
      isEarlyWinner = false;
      winnerId = topPlayers[0]["playerID"];
    } else {
      isTie = true;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isEarlyWinner &&
            currentPlayer["playerID"] == highestPlayerId)
          SizedBox(
            width: 290.w,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "WINNER!! But, play the game out for pride.",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 23.sp,
                  fontFamily: 'Scoreboard',
                ),
              ),
            ),
          ),
        if (isWinner && currentPlayer["playerID"] == winnerId)
          Text(
            "WINNER!!",
            style: TextStyle(
              color: Colors.red,
              fontSize: 23.sp,
              fontFamily: 'Scoreboard',
            ),
          ),
        if (isTie && topPlayers.contains(currentPlayer))
          SizedBox(
            width: 290.w,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Is going for the win! The next correct answer from ${currentPlayer["playerName"]} will win the game.",
                style: TextStyle(
                  color: const Color.fromRGBO(11, 32, 77, 1),
                  fontSize: 10.sp,
                  fontFamily: 'Norwester',
                ),
              ),
            ),
          ),
        if (currentPlayer["playerStreak"] >= 2)
          Text(
            "🔥 Is on a hot streak with ${currentPlayer["playerStreak"]} correct in a row!",
            style: TextStyle(
              color: const Color.fromRGBO(11, 32, 77, 1),
              fontSize: 10.sp,
              fontFamily: 'Norwester',
            ),
          ),
        if (getScoreMessage(currentPlayer["score"]) != "null")
          SizedBox(
            width: 290.w,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                getScoreMessage(currentPlayer["score"]),
                style: TextStyle(
                  color: const Color.fromRGBO(11, 32, 77, 1),
                  fontSize: 10.sp,
                  fontFamily: 'Norwester',
                ),
              ),
            ),
          ),
        if (currentPlayer["wrongStreak"] >= 2 &&
            currentPlayer["playerStreak"] < 4)
          Text(
            "💩 Wrong streak in play!! answered ${currentPlayer["wrongCount"]} wrong items in a row!",
            style: TextStyle(
              color: const Color.fromRGBO(11, 32, 77, 1),
              fontSize: 8.sp,
              fontFamily: 'Norwester',
            ),
          ),
        if (currentPlayer["wrongCount"] >= 4)
          Text(
            "Is now up to ${currentPlayer["wrongCount"]} wrong guesses. Maaaybe think before you speak Meatsauce.",
            style: TextStyle(
              color: const Color.fromRGBO(11, 32, 77, 1),
              fontSize: 8.sp,
              fontFamily: 'Norwester',
            ),
          ),
        if (currentPlayer["wrongCount"] != 0 && currentPlayer["wrongCount"] < 4)
          Text(
            "Has guessed ${currentPlayer["wrongCount"]} wrong.",
            style: TextStyle(
              color: const Color.fromRGBO(11, 32, 77, 1),
              fontSize: 10.sp,
              fontFamily: 'Norwester',
            ),
          ),
      ],
    );
  }

  Future<void> initializeAnimation() async {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void playSound(String soundName) {
    audioPlayer1.play(
      AssetSource('audio/$soundName.mp3'),
      volume: 2,
    );
  }

  Widget _buildButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      height: 50.h,
      decoration: BoxDecoration(
        color: isClue ? const Color.fromRGBO(41, 56, 91, 1) : Colors.red,
        borderRadius: BorderRadius.circular(2.r),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: Text(
          isClue
              ? 'ANNOUNCE CLUE #$clueIndex'
              : "NOBODY ANSWERED ITEM $itemCount CORRECTLY",
          style: TextStyle(
            color: const Color.fromRGBO(255, 255, 255, 1),
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  void manageButton() {
    setState(() {
      if (!isClue) {
        wrongIndexes.clear();
        if (itemCount >= 12) {
          tieBreakerIndex++;
          displayMessage =
              "TIEBREAKER INITIALS item $tieBreakerIndex of the initials ${widget.initials}";
        } else {
          itemCount++;
          displayMessage =
              "Item $itemCount of the initials ${widget.initials}. Time for a game recap before announcing the next clue.";
        }
        clueIndex = 1;
        isClue = true;
        showWrongRight = false;
        _controller.reverse();
      } else if (clueIndex == 6) {
        playSound("clue-6");
        displayMessage = itemCount >= 12
            ? "Read clue number $clueIndex of TIEBREAKER INITIALS item $tieBreakerIndex of the initials ${widget.initials}"
            : "Read clue number $clueIndex of item $itemCount of the initials ${widget.initials}";
        clueIndex = 1;
        isClue = false;
      } else {
        displayMessage = itemCount >= 12
            ? "Read clue number $clueIndex of TIEBREAKER INITIALS item $tieBreakerIndex of the initials CF"
            : "Read clue number $clueIndex of item $itemCount of the initials ${widget.initials}";
        clueIndex++;
        playSound("clue-$clueIndex");
        showWrongRight = true;
        _controller.forward();
      }
    });
  }

  void manageButton1() {
    setState(() {
      if (!isClue) {
        wrongIndexes.clear();
        if (itemCount >= 12) {
          tieBreakerIndex++;
          displayMessage =
              "TIEBREAKER INITIALS item $tieBreakerIndex of the initials ${widget.initials}";
        } else {
          itemCount++;
          displayMessage =
              "Item $itemCount of the initials ${widget.initials}. Time for a game recap before announcing the next clue.";
        }
        clueIndex = 1;
        isClue = true;
        showWrongRight = false;
        _controller.reverse();
      } else if (clueIndex == 6) {
        playSound("clue-6");
        displayMessage = itemCount >= 12
            ? "Read clue number $clueIndex of TIEBREAKER INITIALS item $tieBreakerIndex of the initials ${widget.initials}"
            : "Read clue number $clueIndex of item $itemCount of the initials ${widget.initials}";
        clueIndex = 1;
        isClue = false;
      } else {
        displayMessage = itemCount >= 12
            ? "Read clue number $clueIndex of TIEBREAKER INITIALS item $tieBreakerIndex of the initials CF"
            : "Read clue number $clueIndex of item $itemCount of the initials ${widget.initials}";
        clueIndex++;
        playSound("clue-$clueIndex");
        showWrongRight = true;
        _controller.forward();
      }
    });
  }

  String getScoreMessage(int playerScore) {
    int highestScore = playersWithScores.fold(
        0, (max, player) => max > player["score"] ? max : player["score"]);
    if (highestScore == 0) return "null";

    int countHighestScore = playersWithScores
        .where((player) => player["score"] == highestScore)
        .length;
    int difference = highestScore - playerScore;

    if ((12 - itemCount + 1) < (highestScore - playerScore)) {
      return "Has been mathematically eliminated.";
    }

    if (playerScore == highestScore) {
      return countHighestScore == 1
          ? "All alone in the lead!!"
          : "Tied for the lead!!";
    } else {
      return difference > 4
          ? "Is $difference back from the leader.. Could this be Parrish with us today?"
          : "Is $difference back from the leader.";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    audioPlayer1.dispose();
    myScrollController.dispose();
    super.dispose();
  }


  void endGame() async {

    if(!isWinnerState) return;

    // make a list of players with their scores
    List<Map<String, dynamic>> players = playersWithScores.map((player) {
      return {
        "playerName": player["playerName"],
        "score": player["score"],
      };
    }).toList();

    // get winner name
    String winnerName = playersWithScores
        .firstWhere((player) => player["score"] == topPlayers[0]["score"])["playerName"];

    final userId = Supabase.instance.client.auth.currentUser?.id ?? '';
    await saveGameHistory(
      userId: userId,
      players: players,
      initials: widget.initials,
      winnerName: winnerName,
    );
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return isWinnerState ?
            true
            : await _showExitConfirmationDialog(context);
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            fetchGameHistory();
          },
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/initials-bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              controller: myScrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.verticalSpace,
                        Text(
                          displayMessage,
                          style: TextStyle(
                            color: const Color.fromRGBO(11, 32, 77, 1),
                            fontSize: 12.sp,
                            fontFamily: 'Norwester',
                          ),
                        ),
                        10.verticalSpace,
                        if (!isWinnerState)
                          Row(
                            children: [
                              InkWell(
                                onTap: manageButton,
                                child: _buildButton(),
                              ),
                            ],
                          ),
                        20.verticalSpace,
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ListView.builder(
                      controller: myScrollController,
                      shrinkWrap: true,
                      itemCount: players.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(5.r),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.15),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        players[index],
                                        style: TextStyle(
                                          color:
                                              const Color.fromRGBO(11, 32, 77, 1),
                                          fontSize: 14.sp,
                                          fontFamily: 'Norwester',
                                        ),
                                      ),
                                      _commentBox(playersWithScores[index]),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: 0.5.h,
                                color: Colors.grey.withOpacity(0.5),
                                margin: EdgeInsets.symmetric(vertical: 2.h),
                              ),
                              10.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if (showWrongRight)
                                    SlideTransition(
                                      position: _offsetAnimation,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (wrongIndexes.contains(index))
                                                return;
                                              playSound("wrong");
                                              setState(() {
                                                wrongIndexes.add(index);
                                                playersWithScores[index]
                                                    ["playerStreak"] = 0;
                                                playersWithScores[index]
                                                    ["wrongCount"]++;
                                                playersWithScores[index]
                                                    ["wrongStreak"]++;
                                                for (int i = 0;
                                                    i < playersWithScores.length;
                                                    i++) {
                                                  if (i != index) {
                                                    playersWithScores[i]
                                                        ["wrongStreak"] = 0;
                                                  }
                                                }
                                                if (wrongIndexes.length ==
                                                    players.length) {
                                                  isClue = false;
                                                }
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 6.h),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2.r),
                                                color:
                                                    wrongIndexes.contains(index)
                                                        ? wrongBoxColor
                                                        : Colors.red,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.25),
                                                    offset: Offset(0, 4),
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                'WRONG!!!',
                                                style: TextStyle(
                                                  color:
                                                      wrongIndexes.contains(index)
                                                          ? wrongTextColor
                                                          : Colors.white,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                          5.horizontalSpace,
                                          InkWell(
                                            onTap: () {
                                              if (wrongIndexes.contains(index))
                                                return;
                                              playSound("thats-right");
                                              setState(() {
                                                playersWithScores[index]
                                                    ["score"]++;
                                                playersWithScores[index]
                                                    ["playerStreak"]++;
                                                for (int i = 0;
                                                    i < playersWithScores.length;
                                                    i++) {
                                                  if (i != index) {
                                                    playersWithScores[i]
                                                        ["playerStreak"] = 0;
                                                  }
                                                }

                                                // Check if total score is 12
                                                int totalScore =
                                                    playersWithScores.fold<int>(
                                                        0,
                                                        (sum, player) =>
                                                            sum + player["score"]
                                                                as int);
                                                totalPlayerScore = totalScore;

                                                if (totalScore >= 12) {
                                                  int highestScore =
                                                      playersWithScores.fold(
                                                          0,
                                                          (max, player) => max >
                                                                  player["score"]
                                                              ? max
                                                              : player["score"]);
                                                  topPlayers = playersWithScores
                                                      .where((player) =>
                                                          player["score"] ==
                                                          highestScore)
                                                      .toList();

                                                  if (topPlayers.length == 1) {
                                                    isWinnerState = true;
                                                    displayMessage =
                                                        "Thanks for using the Initials Scoreboard to play The Initials Game. Refresh the page to start another round.";
                                                    showWrongRight = false;
                                                    endGame();
                                                  }
                                                } else {
                                                  itemCount++;
                                                  displayMessage =
                                                      "Item $itemCount of the initials ${widget.initials}. Time for a game recap before announcing the next clue.";
                                                  clueIndex = 1;
                                                  isClue = true;
                                                  showWrongRight = false;
                                                  wrongIndexes.clear();
                                                  _controller.reverse();
                                                }
                                              });

                                              return;
                                              if (wrongIndexes.contains(index))
                                                return;
                                              playSound("thats-right");
                                              setState(() {
                                                playersWithScores[index]
                                                    ["score"]++;
                                                playersWithScores[index]
                                                    ["playerStreak"]++;
                                                for (int i = 0;
                                                    i < playersWithScores.length;
                                                    i++) {
                                                  if (i != index) {
                                                    playersWithScores[i]
                                                        ["playerStreak"] = 0;
                                                  }
                                                }
                                                itemCount++;
                                                displayMessage =
                                                    "Item $itemCount of the initials ${widget.initials}. Time for a game recap before announcing the next clue.";
                                                clueIndex = 1;
                                                isClue = true;
                                                showWrongRight = false;
                                                wrongIndexes.clear();
                                                _controller.reverse();
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 6.h),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2.r),
                                                color:
                                                    wrongIndexes.contains(index)
                                                        ? wrongBoxColor
                                                        : Colors.green,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.25),
                                                    offset: Offset(0, 4),
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                'THAT\'S RIGHT!',
                                                style: TextStyle(
                                                  color:
                                                      wrongIndexes.contains(index)
                                                          ? wrongTextColor
                                                          : Colors.white,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (!showWrongRight) const SizedBox.shrink(),
                                  Text(
                                    "${playersWithScores[index]["score"]}",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 23.sp,
                                      fontFamily: 'Scoreboard',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const FooterSheet(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> _showExitConfirmationDialog(BuildContext context) async {
  return (await showDialog<bool>(
    context: context,
    barrierDismissible: false, // Prevent dismiss by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Exit'),
        content: Text('Are you sure you want to leave the game?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false); // Return false to prevent exit
            },
          ),
          TextButton(
            child: Text('Leave'),
            onPressed: () {
              Navigator.of(context).pop(true); // Return true to allow exit
            },
          ),
        ],
      );
    },
  )) ?? false;
}
