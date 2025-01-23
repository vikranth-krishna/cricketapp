import 'package:binimise/screens/player_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/database_helper.dart';
import '../models/player.dart';
import '../services/player_service.dart';
import '../services/api/player_api.dart'; // Import PlayerAPI
import 'login_screen.dart';


class HomeScreen extends StatefulWidget {
  final String userType;

  HomeScreen({required this.userType});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Player> _players = [];
  List<Player> _filteredPlayers = [];
  final TextEditingController _searchController = TextEditingController();
  final PlayerService _playerService = PlayerService();

  @override
  void initState() {
    super.initState();
    _initializePlayerData();
    _searchController.addListener(_filterPlayers);
  }

  Future<void> _initializePlayerData() async {
    // Check if players are already in the database
    List<Player> dbPlayers = await _playerService.getPlayersFromDatabase();
    if (dbPlayers.isEmpty) {
      // Save players to database if empty
      await _playerService.savePlayersToDatabase();
      dbPlayers = await _playerService.getPlayersFromDatabase();
    }

    setState(() {
      _players = dbPlayers;
      _filteredPlayers = dbPlayers;
    });
  }

  void _filterPlayers() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPlayers = _players.where((player) {
        return player.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _showOptionsDialog(Player player) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Choose an action'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Add'),
              onTap: () async {
                Navigator.pop(context);

                // Uncomment this block when enabling API
                // final success = await PlayerAPI.addPlayer(player.toJson());
                // if (success) {
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Player added successfully')));
                // }
              },
            ),
            ListTile(
              title: Text('Edit'),
              onTap: () async {
                Navigator.pop(context);

                // Uncomment this block when enabling API
                // final success = await PlayerAPI.updatePlayer(player.id.toString(), player.toJson());
                // if (success) {
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Player updated successfully')));
                // }
              },
            ),
            ListTile(
              title: Text('Delete'),
              onTap: () async {
                Navigator.pop(context);

                // Uncomment this block when enabling API
                // final success = await PlayerAPI.deletePlayer(player.id.toString());
                // if (success) {
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Player deleted successfully')));
                // }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cricket Players - ${widget.userType}'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('userType');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Players...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _filteredPlayers.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: _filteredPlayers.length,
              itemBuilder: (context, index) {
                var player = _filteredPlayers[index];
                return ListTile(
                  title: Text(player.name),
                  subtitle: Text('Team: ${player.team}'),
                  trailing: widget.userType == 'Super Admin'
                      ? IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () => _showOptionsDialog(player),
                  )
                      : null,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerDetailsScreen(player: player),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
