class Event {
  static const String collectionName = 'Events';
  String? id;
  String? name;
  String? title;
  String? description;
  String? image;
  String? category;
  DateTime? date;
  String? time;
  bool isFavorite;
  int? index;
  double? latitude;
  double? longitude;
  String? locationName;

  Event({
    this.id = '',
    required this.name,
    required this.title,
    required this.description,
    required this.image,
    required this.category,
    required this.date,
    required this.time,
    this.isFavorite = false,
    this.index = 0,
    required this.latitude,
    required this.longitude,
    required this.locationName,
  });

  Event.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data!['id'],
          name: data['name'],
          title: data['title'],
          description: data['description'],
          image: data['image'],
          category: data['category'],
          isFavorite: data['isFavorite'],
          date: DateTime.fromMillisecondsSinceEpoch(data['date']),
          time: data['time'],
          index: data['index'],
          latitude: data['latitude'],
          longitude: data['longitude'],
          locationName: data['locationName'],
        );

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'description': description,
      'image': image,
      'category': category,
      'isFavorite': isFavorite,
      'date': date!.millisecondsSinceEpoch,
      'time': time,
      'index': index,
      'latitude': latitude,
      'longitude': longitude,
      'locationName': locationName,
    };
  }
}
