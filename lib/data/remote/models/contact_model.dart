import '../../../domain/entities/contact_entity.dart';
import '../../../domain/entities/user_entity.dart';

class ContactModel extends ContactEntity {
  ContactModel({
    required super.id,
    required super.email,
    required super.username,
    required super.name,
    required super.surname,
    super.chatId,
  });

  factory ContactModel.fromUserEntity(UserEntity user) {
    return ContactModel(
        id: user.id,
        email: user.email,
        username: user.username,
        name: user.name,
        surname: user.surname);
  }
}
