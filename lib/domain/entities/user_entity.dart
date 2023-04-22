import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String username;
  final String email;
  final String name;
  final String surname;

  const UserEntity(
      {required this.id,
      required this.email,
      required this.username,
      required this.name,
      required this.surname});

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'],
      email: map['email'],
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
      'email': email,
    };
  }

  @override
  List<Object?> get props => [id, username, email, name, surname];
}
