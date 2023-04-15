class SearchUser {
  final String id;
  final String name;
  final String surname;
  //final String image;
  final bool isInvited;

  SearchUser(
      {required this.id,
      required this.name,
      required this.surname,
      required this.isInvited});

  static SearchUser fromMap(String id, Map<String, dynamic> map) {
    return SearchUser(
        id: id,
        name: map['name'] ?? 'Name',
        surname: map['surname'] ?? 'Surname',
        isInvited: false);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
