class Activity {
  final String activity;
  final double availability;
  final String type;
  final int participants;
  final double price;
  final String accessibility;
  final String duration;
  final bool kidFriendly;
  final String link;
  final String key;

  // This is the constructor for creating an Activity object.
  // The 'required' keyword ensures that all these values must be provided.
  const Activity({
    required this.activity,
    required this.availability,
    required this.type,
    required this.participants,
    required this.price,
    required this.accessibility,
    required this.duration,
    required this.kidFriendly,
    required this.link,
    required this.key,
  });

  // This is a factory constructor for creating an Activity object from a JSON map.
  factory Activity.fromJson(Map<String, dynamic> json) {
    // This uses Dart 3's modern switch expression with a map pattern.
    // It checks if the JSON map contains the correct keys and types.
    return switch (json) {
      {
        'activity': String activity,
        'availability':
            num availability, // Use 'num' to handle both int and double
        'type': String type,
        'participants': int participants,
        'price': num price, // Use 'num' to handle both int (like 0) and double
        'accessibility': String accessibility,
        'duration': String duration,
        'kidFriendly': bool kidFriendly,
        'link': String link,
        'key': String key,
      } =>
        // If the pattern matches, create and return a new Activity instance.
        Activity(
          activity: activity,
          availability: availability.toDouble(),
          type: type,
          participants: participants,
          price: price.toDouble(),
          accessibility: accessibility,
          duration: duration,
          kidFriendly: kidFriendly,
          link: link,
          key: key,
        ),
      // The '_' is a wildcard pattern that catches any map that doesn't match the pattern above.
      // This is used for error handling, for example, if the JSON is missing a key or a value is of the wrong type.
      _ => throw const FormatException('Failed to load activity from JSON.'),
    };
  }
}
