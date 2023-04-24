import '../../domain/entities/chat_entity.dart';
import '../../domain/repositories/base_chat_repository.dart';
import '../remote/datasources/base_firebase_chat_data_source.dart';

class ChatRepository extends BaseChatRepository {
  final BaseFirebaseChatDataBase _firebaseChatDataBase;

  ChatRepository({required BaseFirebaseChatDataBase firebaseChatDataBase})
      : _firebaseChatDataBase = firebaseChatDataBase;

  @override
  Future<String> createChat(ChatEntity chat) async {
    return await _firebaseChatDataBase.createChat(chat);
  }

  @override
  Future<ChatEntity> getChatById(String chatId) async {
    return await _firebaseChatDataBase.getChatById(chatId);
  }
}
