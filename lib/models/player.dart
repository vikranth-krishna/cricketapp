class Player {
  final String name;
  final int age;
  final String scoreDaily;
  final String scoreYearly;
  final String bestPerformance;
  final int wickets;
  final String battingStyle;
  final String bowlingStyle;
  final String team;

  Player({
    required this.name,
    required this.age,
    required this.scoreDaily,
    required this.scoreYearly,
    required this.bestPerformance,
    required this.wickets,
    required this.battingStyle,
    required this.bowlingStyle,
    required this.team,
  });

  // Factory constructor to create a Player from JSON
  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'],
      age: json['age'],
      scoreDaily: json['score_daily'],
      scoreYearly: json['score_yearly'],
      bestPerformance: json['best_performance'],
      wickets: json['wickets'],
      battingStyle: json['batting_style'],
      bowlingStyle: json['bowling_style'],
      team: json['team'],
    );
  }

  // Method to convert a Player instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'score_daily': scoreDaily,
      'score_yearly': scoreYearly,
      'best_performance': bestPerformance,
      'wickets': wickets,
      'batting_style': battingStyle,
      'bowling_style': bowlingStyle,
      'team': team,
    };
  }
}