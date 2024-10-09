import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:the_initials/appConstants.dart';

import '../Services.dart';
import 'package:expansion_widget/expansion_widget.dart';

class GameHistoryScreen extends StatefulWidget {
  const GameHistoryScreen({super.key});

  @override
  _GameHistoryScreenState createState() => _GameHistoryScreenState();
}

class _GameHistoryScreenState extends State<GameHistoryScreen> {
  List<Map<String, dynamic>> _gameHistory = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchGameHistory();
  }

  Future<void> _fetchGameHistory() async {
    try {
      final history = await fetchGameHistory();
      setState(() {
        _gameHistory = history;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
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
          child: Column(
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
                      'Game History',
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
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _hasError
                  ? const Center(child: Text('Error fetching game history.'))
                  : _gameHistory.isEmpty
                  ? const Center(child: Text('No game history found.'))
                  : ListView.builder(
                    padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: _gameHistory.length,
                          itemBuilder: (context, index) {
                  final game = _gameHistory[index];
                  final playerData = game['players'] ;
                  final winnerName = game['winner_name'] ?? 'Unknown';
                  final gameDate = DateTime.parse(game['game_date']).toLocal();
                  final gameInitials = game['initials'];
                  final DateFormat formatter = DateFormat('M/d/yy h:mm a');
                  // Format the current date and time
                  final formattedDateTime = formatter.format(gameDate);

                  return ExpansionWidget(
                      initiallyExpanded: false,
                      titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
                        return InkWell(
                            onTap: () => toogleFunction(animated: true),
                            child:Container(
                              height: 74.h,
                              margin: EdgeInsets.only(bottom: 10.h,right: 10.w,left: 10.w),
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
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
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Date and time: $formattedDateTime',
                                        style: kTextStyles12Norwester,
                                      ),
                                      Text('Total Players: ${playerData.length}',
                                        style: kTextStyles12Norwester,),
                                      Text('Winner Name: $winnerName',
                                        style: kTextStyles12Norwester,),
                                    ],
                                  ),
                                  const Spacer(),
                                  isExpaned
                                      ? Icon(Icons.keyboard_arrow_up,color: Colors.white,)
                                      : Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                                ],
                              ),
                            )
                        );
                      },
                      content: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: playerData.length,
                        itemBuilder: (context, index) {
                          final player = playerData[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 10.h,right: 10.w,left: 10.w),
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
                                  player['playerName'],
                                  style: kTextStyles14Norwester,
                                ),
                                Text(
                                  player['score'].toString(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14.sp,
                                      fontFamily: 'Norwester',
                                  ),
                                ),
                              ],
                            ),
                          );
                          return ListTile(
                            title: Text(player['playerName']),
                          );
                        },
                      )
                  );

                  return ListTile(
                    onTap: () {

                    },
                    title: Text('Game on ${gameDate.toLocal()}'),
                    subtitle: Text('Winner: $winnerName\nScores:   $gameInitials\nPlayers: $playerData'),
                  );
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
