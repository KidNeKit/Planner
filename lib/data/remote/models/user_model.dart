import '../../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.id,
      required super.email,
      required super.username,
      required super.name,
      required super.surname});
}
