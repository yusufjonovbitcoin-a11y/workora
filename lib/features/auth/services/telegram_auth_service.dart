import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/telegram_user_local.dart';

const _prefsTelegramUserKey = 'workora_telegram_user_json';

/// Telegram bot deep-link: token yaratish, botni ochish, polling, mahalliy saqlash.
class TelegramAuthService {
  TelegramAuthService(this._client);

  final SupabaseClient _client;

  /// Edge Function: yangi token + `https://t.me/<bot>?start=<token>`.
  Future<({String token, String botUrl})> createLoginToken() async {
    final res = await _client.functions.invoke('create-telegram-login-token');
    final data = res.data;
    if (data is! Map) {
      throw StateError('create-telegram-login-token: noto‘g‘ri javob');
    }
    final map = Map<String, dynamic>.from(data);
    final token = map['token'] as String?;
    final botUrl = map['bot_url'] as String?;
    if (token == null || token.isEmpty || botUrl == null || botUrl.isEmpty) {
      throw StateError('create-telegram-login-token: token yoki bot_url yo‘q');
    }
    return (token: token, botUrl: botUrl);
  }

  Future<void> openTelegramBot(String botUrl) async {
    final uri = Uri.parse(botUrl);
    final opened = await launchUrl(
      uri,
      mode: kIsWeb
          ? LaunchMode.platformDefault
          : LaunchMode.externalApplication,
    );
    if (!opened) {
      throw StateError('Telegram ilovasini ochib bo‘lmadi');
    }
  }

  /// Bir marta tekshirish — `{ status, telegram_user?, auth_token_hash? }`.
  Future<Map<String, dynamic>> checkTokenOnce(String token) async {
    final res = await _client.functions.invoke(
      'check-telegram-login-token',
      body: {'token': token},
    );
    final data = res.data;
    if (data is! Map) {
      return {'status': 'invalid'};
    }
    return Map<String, dynamic>.from(data);
  }

  /// Har 2 soniyada so‘raydi; `cancelled == true` bo‘lsa darhol tugaydi.
  Future<TelegramPollResult> pollToken(
    String token, {
    required bool Function() cancelled,
    Duration interval = const Duration(seconds: 2),
  }) async {
    while (!cancelled()) {
      final map = await checkTokenOnce(token);
      final status = map['status'] as String? ?? 'invalid';
      if (status == 'confirmed') {
        final raw = map['telegram_user'];
        final tokenHash = map['auth_token_hash'] as String?;
        if (raw is Map && tokenHash != null && tokenHash.isNotEmpty) {
          return TelegramPollResult.confirmed(
            TelegramUserLocal.fromJson(Map<String, dynamic>.from(raw)),
            authTokenHash: tokenHash,
            authEmail: map['auth_email'] as String?,
          );
        }
        return const TelegramPollResult.invalid();
      }
      if (status == 'expired' || status == 'invalid') {
        return TelegramPollResult.done(status);
      }
      await Future<void>.delayed(interval);
    }
    return const TelegramPollResult.cancelled();
  }

  Future<void> exchangeTelegramTokenForSession(
    TelegramPollResult result,
  ) async {
    final tokenHash = result.authTokenHash;
    if (!result.isConfirmed || tokenHash == null || tokenHash.isEmpty) {
      throw StateError('Telegram auth token topilmadi.');
    }

    await _client.auth.verifyOTP(type: OtpType.magiclink, tokenHash: tokenHash);
  }

  Future<void> saveLocalTelegramUser(TelegramUserLocal user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsTelegramUserKey, jsonEncode(user.toJson()));
  }

  static Future<TelegramUserLocal?> readLocalTelegramUser() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsTelegramUserKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      final map = jsonDecode(raw);
      if (map is! Map) return null;
      return TelegramUserLocal.fromJson(Map<String, dynamic>.from(map));
    } catch (_) {
      return null;
    }
  }

  static Future<void> clearLocalTelegramUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsTelegramUserKey);
  }
}

class TelegramPollResult {
  const TelegramPollResult._(
    this.status,
    this.user, {
    this.authTokenHash,
    this.authEmail,
  });

  final String status;
  final TelegramUserLocal? user;
  final String? authTokenHash;
  final String? authEmail;

  const TelegramPollResult.confirmed(
    TelegramUserLocal u, {
    required String authTokenHash,
    String? authEmail,
  }) : this._(
         'confirmed',
         u,
         authTokenHash: authTokenHash,
         authEmail: authEmail,
       );

  const TelegramPollResult.done(String status) : this._(status, null);

  const TelegramPollResult.cancelled() : this._('cancelled', null);

  const TelegramPollResult.invalid() : this._('invalid', null);

  bool get isConfirmed => status == 'confirmed' && user != null;
}
