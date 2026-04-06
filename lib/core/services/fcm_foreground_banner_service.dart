import 'dart:async';

import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/app_global_keys.dart';
import 'package:eduroom/core/helpers/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/// Tətbiq **açıq olanda** (foreground) gələn FCM mesajını yuxarıdan banner kimi göstərir.
/// Arxa planda sistem tray bildirişi backend payload-ından asılıdır.
class FcmForegroundBannerService {
  FcmForegroundBannerService._();

  static StreamSubscription<RemoteMessage>? _sub;
  static OverlayEntry? _currentEntry;
  static Timer? _hideTimer;

  /// Firebase init olubsa bir dəfə dinləyici qoşur (təkrar çağırış təhlükəsizdir).
  static void attachIfFirebaseReady() {
    if (_sub != null) return;
    try {
      if (Firebase.apps.isEmpty) return;
    } catch (_) {
      return;
    }
    _sub = FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    log.info('FCM foreground banner dinləyicisi qoşuldu');
  }

  static void dispose() {
    _hideTimer?.cancel();
    _hideTimer = null;
    _sub?.cancel();
    _sub = null;
    _removeEntry();
  }

  static void _onForegroundMessage(RemoteMessage message) {
    final title = message.notification?.title ??
        message.data['title']?.toString() ??
        'Bildiriş';
    final body = message.notification?.body ?? message.data['body']?.toString() ?? '';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final nav = AppGlobalKeys().navigatorState;
      if (nav == null || !nav.mounted) return;
      final overlay = nav.overlay;
      if (overlay == null) return;
      _showOnOverlay(overlay, title, body);
    });
  }

  static void _showOnOverlay(OverlayState overlay, String title, String body) {
    _hideTimer?.cancel();
    _removeEntry();

    late OverlayEntry entry;
    void dismiss() {
      _hideTimer?.cancel();
      _hideTimer = null;
      entry.remove();
      if (identical(_currentEntry, entry)) _currentEntry = null;
    }

    entry = OverlayEntry(
      builder: (context) => _TopNotificationBanner(
        title: title,
        body: body,
        onClose: dismiss,
      ),
    );
    _currentEntry = entry;
    overlay.insert(entry);

    _hideTimer = Timer(const Duration(seconds: 5), dismiss);
  }

  static void _removeEntry() {
    _hideTimer?.cancel();
    _hideTimer = null;
    _currentEntry?.remove();
    _currentEntry = null;
  }
}

class _TopNotificationBanner extends StatefulWidget {
  const _TopNotificationBanner({
    required this.title,
    required this.body,
    required this.onClose,
  });

  final String title;
  final String body;
  final VoidCallback onClose;

  @override
  State<_TopNotificationBanner> createState() => _TopNotificationBannerState();
}

class _TopNotificationBannerState extends State<_TopNotificationBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, -1.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _close() async {
    await _controller.reverse();
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.paddingOf(context);
    return Positioned(
      left: 12,
      right: 12,
      top: pad.top + 6,
      child: SlideTransition(
        position: _slide,
        child: Material(
          elevation: 10,
          shadowColor: Colors.black26,
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
          child: InkWell(
            onTap: _close,
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.notifications_active_rounded, color: AppColors.bgColor, size: 26),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: AppColors.black900,
                          ),
                        ),
                        if (widget.body.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            widget.body,
                            style: const TextStyle(fontSize: 13, color: AppColors.black500),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _close,
                    icon: const Icon(Icons.close, size: 20, color: AppColors.black300),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
