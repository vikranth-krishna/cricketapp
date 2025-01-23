import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/player.dart';
import '../db/database_helper.dart';

class PlayerService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Load the JSON data from assets
  Future<List<Player>> loadPlayers() async {
    String jsonString = await rootBundle.loadString('assets/players.json');
    List<dynamic> jsonResponse = jsonDecode(jsonString);

    // Map the JSON data to Player objects
    List<Player> players = jsonResponse.map((data) => Player.fromJson(data)).toList();

    return players;
  }

  // Save players to the database
  Future<void> savePlayersToDatabase() async {
    List<Player> players = await loadPlayers();
    for (var player in players) {
      await _dbHelper.insertPlayer(player);
    }
  }

  // Get players from the database
  Future<List<Player>> getPlayersFromDatabase() async {
    return await _dbHelper.getPlayers();
  }
}
