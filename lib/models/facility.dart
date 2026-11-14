class Facility {
  final String id, name, category, location, description, operatingHours, iconName, status;
  const Facility({required this.id, required this.name, required this.category, required this.location, required this.description, required this.operatingHours, required this.iconName, required this.status});
  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
    id: json['id'] as String, name: json['name'] as String, category: json['category'] as String,
    location: json['location'] as String, description: json['description'] as String,
    operatingHours: json['operatingHours'] as String, iconName: json['iconName'] as String,
    status: json['status'] as String,
  );
}
