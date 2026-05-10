import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAiChatService {
  const SupabaseAiChatService();

  Future<String> generateReply(String userMessage) async {
    try {
      if (!Supabase.instance.isInitialized) {
        return 'Supabase sozlanmagan. AI chat funksiyasini ishga tushirib bo‘lmadi.';
      }

      final response = await Supabase.instance.client.functions.invoke(
        'ai-chat',
        body: {'message': userMessage},
      );

      final data = response.data;
      if (data is Map && data['reply'] != null) {
        return data['reply'].toString();
      }

      if (data is Map && data['error'] != null) {
        return data['error'].toString();
      }

      return 'AI xato qaytardi yoki javob bo‘sh.';
    } catch (error, stackTrace) {
      debugPrint('AI Chat Service Error: $error');
      debugPrintStack(stackTrace: stackTrace);
      return 'Tarmoq xatosi yoki funksiya ishlamayapti.';
    }
  }
}
