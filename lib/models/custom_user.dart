import 'package:equatable/equatable.dart';

class CustomUser extends Equatable {
  final String? id;
  final String username;
  final String email;
  final String name;
  final String surname;

  const CustomUser(
      {required this.id,
      required this.email,
      required this.username,
      required this.name,
      required this.surname});

  static CustomUser fromMap(Map<String, dynamic> map) {
    return CustomUser(
      id: map['id'],
      email: map['email'],
      username: map['username'],
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, username, email, name, surname];
}
