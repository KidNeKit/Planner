class EventEntity {
  final String eventName;
  final String eventLocation;
  final DateTime startDate;
  final DateTime endDate;

  EventEntity(
      {required this.eventName,
      required this.eventLocation,
      required this.startDate,
      required this.endDate});

  Map<String, dynamic> toMap() {
    return {
      'eventName': eventName,
      'eventLocation': eventLocation,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory EventEntity.fromMap(Map<String, dynamic> map) {
    return EventEntity(
        eventName: map['eventName'],
        eventLocation: map['eventLocation'],
        startDate: DateTime.parse(map['startDate'].toDate().toString()),
        endDate: DateTime.parse(map['endDate'].toDate().toString()));
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
