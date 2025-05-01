import '../../domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  EventModel({
    required String id,
    required String name,
    required String description,
    required DateTime date,
    required String location,
    required String imageUrl,
    double? latitude,
    double? longitude,
  }) : super(
    id: id,
    name: name,
    description: description,
    date: date,
    location: location,
    imageUrl: imageUrl,
    latitude: latitude,
    longitude: longitude,
  );

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      imageUrl: json['imageUrl'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
