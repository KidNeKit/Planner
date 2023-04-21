import 'package:equatable/equatable.dart';

class ContactUser extends Equatable {
  final String id;
  final String username;
  final String name;
  final String surname;

  const ContactUser(
      {required this.id,
      required this.username,
      required this.name,
      required this.surname});

  static ContactUser fromMap(Map<String, dynamic> map) {
    return ContactUser(
      id: map['id'],
      username: map['username'],
      name: map['name'],
      surname: map['surname'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'username': username,
    };
  }

  @override
  List<Object?> get props => [id, username, name, surname];
}
