import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../services/telegram_auth_service.dart';

/// Telegram botda `/start` kutilganda — bekor tugmasi bilan.
Future<bool?> showTelegramLoginDialog(
  BuildContext context,
  SupabaseClient client,
) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => _TelegramLoginDialogBody(client: client),
  );
}

class _TelegramLoginDialogBody extends StatefulWidget {
  const _TelegramLoginDialogBody({required this.client});

  final SupabaseClient client;

  @override
  State<_TelegramLoginDialogBody> createState() =>
      _TelegramLoginDialogBodyState();
}

class _TelegramLoginDialogBodyState extends State<_TelegramLoginDialogBody> {
  bool _cancelled = false;
  String? _error;
  bool _starting = true;

  @override
  void initState() {
    super.initState();
    _run();
  }

  Future<void> _run() async {
    final service = TelegramAuthService(widget.client);
    try {
      final created = await service.createLoginToken();
      if (!mounted || _cancelled) return;
      setState(() => _starting = false);
      await service.openTelegramBot(created.botUrl);
      if (!mounted || _cancelled) return;

      final result = await service.pollToken(
        created.token,
        cancelled: () => _cancelled || !mounted,
      );

      if (!mounted) return;

      if (result.isConfirmed && result.user != null) {
        await service.exchangeTelegramTokenForSession(result);
        await service.saveLocalTelegramUser(result.user!);
        if (!mounted) return;
        Navigator.of(context).pop(true);
        return;
      }

      if (result.status == 'expired') {
        setState(() => _error = 'Kod muddati tugadi. Qaytadan urinib ko‘ring.');
        return;
      }

      setState(() => _error = 'Kod yaroqsiz. Qaytadan urinib ko‘ring.');
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _starting = false;
        _error = e.toString();
      });
    }
  }

  void _onCancel() {
    _cancelled = true;
    Navigator.of(context).pop(false);
  }

  void _onCloseAfterError() {
    Navigator.of(context).pop(false);
  }

  void _onRetry() {
    setState(() {
      _error = null;
      _starting = true;
      _cancelled = false;
    });
    _run();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        'Telegram orqali',
        style: TextStyle(
          color: Color(0xFF101828),
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_starting) ...[
            const SizedBox(
              height: 36,
              width: 36,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Havola tayyorlanmoqda…',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF475467)),
            ),
          ] else if (_error == null) ...[
            const SizedBox(
              height: 36,
              width: 36,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Telegram botda /start ni bosing…',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF101828),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Kuting: avtomatik tekshiriladi (2 soniya).',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: const Color(0xFF475467)),
            ),
          ] else ...[
            Icon(Icons.error_outline, size: 40, color: Colors.red.shade400),
            const SizedBox(height: 12),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF475467)),
            ),
          ],
        ],
      ),
      actions: [
        if (_error != null) ...[
          TextButton(
            onPressed: _onCloseAfterError,
            child: const Text('Yopish'),
          ),
          FilledButton(
            onPressed: _onRetry,
            style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Qayta'),
          ),
        ] else
          TextButton(onPressed: _onCancel, child: const Text('Bekor qilish')),
      ],
    );
  }
}
