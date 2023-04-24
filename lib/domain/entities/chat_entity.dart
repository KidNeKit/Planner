import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String? chatId;
  final Set<String> userIds;
  //final List<MessageEntity> messages;

  const ChatEntity({this.chatId, required this.userIds});

  ChatEntity copyWith({String? chatId, Set<String>? userIds}) {
    return ChatEntity(
      userIds: userIds ?? this.userIds,
      chatId: chatId ?? this.chatId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'users': userIds,
    };
  }

  factory ChatEntity.fromMap(Map<String, dynamic> map) {
    return ChatEntity(
      userIds: map['userIds'],
      chatId: map['chatId'],
    );
  }

  factory ChatEntity.fromFirebase(doc) {
    return ChatEntity(
      userIds: doc['userIds'],
      chatId: doc['chatId'],
    );
  }

  @override
  List<Object?> get props => [chatId, userIds];
}
