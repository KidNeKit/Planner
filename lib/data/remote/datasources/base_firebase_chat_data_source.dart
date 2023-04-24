import '../../../domain/entities/chat_entity.dart';

abstract class BaseFirebaseChatDataBase {
  Future<ChatEntity> getChatById(String chatId);
  Future<String> createChat(ChatEntity chat);
}
