import '../entities/chat_entity.dart';

abstract class BaseChatRepository {
  Future<ChatEntity> getChatById(String chatId);
  Future<String> createChat(ChatEntity chat);
}
