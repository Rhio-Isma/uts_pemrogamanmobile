class CampusEvent {
  final String id, title, category, date, time, location, description, organizer, status;
  const CampusEvent({required this.id, required this.title, required this.category, required this.date, required this.time, required this.location, required this.description, required this.organizer, required this.status});
  factory CampusEvent.fromJson(Map<String, dynamic> json) => CampusEvent(
    id: json['id'] as String, title: json['title'] as String, category: json['category'] as String,
    date: json['date'] as String, time: json['time'] as String, location: json['location'] as String,
    description: json['description'] as String, organizer: json['organizer'] as String, status: json['status'] as String,
  );
}
