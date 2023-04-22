import 'package:equatable/equatable.dart';

class SearchUser extends Equatable {
  final String id;
  final String name;
  final String surname;
  final String username;
  //final String image;
  final bool isLoading;
  final bool isInvited;

  const SearchUser(
      {required this.id,
      required this.name,
      required this.surname,
      required this.username,
      required this.isLoading,
      required this.isInvited});

  static SearchUser fromMap(String id, Map<String, dynamic> map) {
    return SearchUser(
      id: id,
      username: map['username'],
      name: map['name'] ?? 'Name',
      surname: map['surname'] ?? 'Surname',
      isInvited: false,
      isLoading: false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'surname': surname,
      'isLoading': isLoading,
      'isInvited': isInvited,
    };
  }

  SearchUser copyWith({
    String? id,
    String? name,
    String? surname,
    String? username,
    bool? isInvited,
    bool? isLoading,
  }) {
    return SearchUser(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      username: username ?? this.username,
      isInvited: isInvited ?? this.isInvited,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  List<Object?> get props =>
      [name, surname, username, id, isInvited, isLoading];
}
