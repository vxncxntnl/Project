// This file defines the ProgramItem class
class ProgramItem {
  String title;
  String description;
  String time;
  String location;
  DateTime date;
  bool isCompleted;
  bool isFavorite;

  ProgramItem({
    required this.title,
    required this.description,
    required this.time,
    required this.location,
    required this.date,
    this.isCompleted = false,
    this.isFavorite = false,
  });

  // Convert to String for SharedPreferences
  String toStorageString() {
    return '$title;$description;$time;$location;${date.toIso8601String()};$isCompleted;$isFavorite';
  }

  // Create from stored String
  static ProgramItem fromStorageString(String storedString) {
    final parts = storedString.split(';');
    return ProgramItem(
      title: parts[0],
      description: parts[1],
      time: parts[2],
      location: parts[3],
      date: DateTime.parse(parts[4]),
      isCompleted: parts[5] == 'true',
      isFavorite: parts[6] == 'true',
    );
  }
}
