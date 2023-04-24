import 'user_entity.dart';

class ContactEntity extends UserEntity {
  String? chatId;

  ContactEntity({
    required super.id,
    required super.email,
    required super.username,
    required super.name,
    required super.surname,
    this.chatId,
  });

  set setChatId(String chatId) => this.chatId = chatId;

  factory ContactEntity.fromMap(Map<String, dynamic> map) {
    return ContactEntity(
      id: map['id'],
      email: map['email'],
      username: map['username'],
      name: map['name'] ?? 'Name',
      surname: map['surname'] ?? 'Surname',
      chatId: map['chatId'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()..putIfAbsent('chatId', () => chatId);
  }

  @override
  List<Object?> get props => [super.props, chatId];
}
