import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase Auth javobi — `error_code` ni qisqacha qo‘shadi (masalan: sms_send_failed).
String formatAuthErrorMessage(AuthException e) {
  final code = e.code;
  if (code != null && code.isNotEmpty) {
    return '${e.message} ($code)';
  }
  return e.message;
}
