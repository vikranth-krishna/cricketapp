import 'package:flutter/material.dart';
import '../models/player.dart';

class PlayerDetailsScreen extends StatelessWidget {
  final Player player;

  PlayerDetailsScreen({required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(player.name ?? 'Player Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              player.name ?? 'N/A',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Age: ${player.age ?? 'N/A'}'),
            Text('Daily Score: ${player.scoreDaily ?? 'N/A'}'),
            Text('Yearly Score: ${player.scoreYearly ?? 'N/A'}'),
            Text('Best Performance: ${player.bestPerformance ?? 'N/A'}'),
            Text('Wickets: ${player.wickets ?? 'N/A'}'),
            Text('Batting Style: ${player.battingStyle ?? 'N/A'}'),
            Text('Bowling Style: ${player.bowlingStyle ?? 'N/A'}'),
            Text('Team: ${player.team ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }
}
