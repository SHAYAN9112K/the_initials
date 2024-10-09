import 'package:supabase_flutter/supabase_flutter.dart';



Future<void> saveGameHistory({
  required String userId,
  required List<Map<String, dynamic>> players, // List of players with their scores
  required String initials, // Initials used in the game
  required String winnerName, // Name of the winner
}) async {
  final supabase = Supabase.instance.client;
  final gameDate = DateTime.now().toIso8601String(); // Current date and time

  try {
    final response = await supabase
        .from('game_history')
        .insert([
      {
        'user_id': userId,
        'game_date': gameDate,
        'players': players, // Store players as JSON
        'initials': initials,
        'winner_name': winnerName,
      }
    ]);

    print('Game history saved');
  } catch (error) {
    print('Error saving game history: $error');
  }

}



// Future<void> fetchGameHistory() async {
//
//   final userId = Supabase.instance.client.auth.currentUser?.id;
//   if (userId == null) return;
//
//   List<Map<String, dynamic>> gameHistory = [];
//
//   final response = await Supabase.instance.client
//       .from('game_history')
//       .select()
//       .eq('user_id', userId)
//       .order('game_date', ascending: false);
//
//
// }

Future<List<Map<String, dynamic>>> fetchGameHistory() async {
  final userId = Supabase.instance.client.auth.currentUser?.id;
  if (userId == null) return [];

  List<Map<String, dynamic>> gameHistory = [];

  try {
    final response = await Supabase.instance.client
        .from('game_history')
        .select()
        .eq('user_id', userId)
        .order('game_date', ascending: false);


    // Process and assign data to the gameHistory list
    gameHistory = List<Map<String, dynamic>>.from(response as List<dynamic>);

    print('Game history fetched: $gameHistory');
    return gameHistory;
  } catch (e) {
    // Handle any exceptions that might occur
    print('Exception occurred while fetching game history: $e');
    return [];
  }
}
