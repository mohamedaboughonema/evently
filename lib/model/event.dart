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
    };
  }
}
