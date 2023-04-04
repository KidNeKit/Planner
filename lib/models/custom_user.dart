import 'package:equatable/equatable.dart';

class CustomUser extends Equatable {
  final String? id;
  final String username;
  final String email;

  const CustomUser(
      {required this.id, required this.email, required this.username});

  @override
  List<Object?> get props => [id, username, email];
}
