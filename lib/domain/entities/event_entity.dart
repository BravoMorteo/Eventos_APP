class EventEntity {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final String location;
  final String imageUrl;
  final double? latitude;
  final double? longitude;

  EventEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.location,
    required this.imageUrl,
    this.latitude,
    this.longitude,
  });
}
