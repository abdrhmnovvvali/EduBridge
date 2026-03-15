import 'dart:async';
import 'package:app_links/app_links.dart';
import '../../core/helpers/logger.dart';

class DeepLinkService {
  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;
  int? _pendingStoryId;
  bool _isInitialized = false;
  bool _isNavigationReady = false;
  
  // Stream controller to notify when a new deep link arrives
  final _deepLinkController = StreamController<int>.broadcast();
  Stream<int> get deepLinkStream => _deepLinkController.stream;

  /// Get the pending story ID if any
  int? get pendingStoryId => _pendingStoryId;

  /// Check if there's a pending deep link
  bool get hasPendingDeepLink => _pendingStoryId != null;

  /// Mark navigation as ready
  void setNavigationReady() {
    _isNavigationReady = true;
  }

  /// Check if navigation is ready
  bool get isNavigationReady => _isNavigationReady;

  /// Clear the pending deep link
  void clearPendingDeepLink() {
    _pendingStoryId = null;
  }

  /// Initialize deep link listening
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Listen for deep links while app is running
      _linkSubscription = _appLinks.uriLinkStream.listen(
        (uri) {
          log.info('Deep link received: $uri');
          _parseAndStoreStoryId(uri);
        },
        onError: (err) {
          log.error('Deep link error: $err');
        },
      );

      _isInitialized = true;
      log.info('Deep link service initialized');
    } catch (e) {
      log.error('Failed to initialize deep link service: $e');
    }
  }

  /// Parse story ID from deep link URL
  void _parseAndStoreStoryId(Uri uri) {
    try {
      // Only process if it's a story deep link
      if (!_isStoryDeepLink(uri)) {
        log.info('Not a story deep link, ignoring: $uri');
        return;
      }

      int? storyId;

      // Handle custom scheme: gringo://story/16
      if (uri.scheme == 'gringo' && uri.host == 'story') {
        final pathSegments = uri.pathSegments;
        if (pathSegments.isNotEmpty) {
          storyId = int.tryParse(pathSegments.first);
        }
      }
      // Handle universal link: https://api.gringo.az/api/share/story/16/
      else if (uri.scheme == 'https') {
        final path = uri.path;
        // Match pattern: /api/share/story/{id}/
        final match = RegExp(r'/api/share/story/(\d+)').firstMatch(path);
        if (match != null) {
          storyId = int.tryParse(match.group(1)!);
        }
      }

      if (storyId != null) {
        _pendingStoryId = storyId;
        log.info('Story ID parsed from deep link: $storyId');
        
        // Notify listeners that a new deep link has arrived
        _deepLinkController.add(storyId);
      } else {
        log.warning('Could not parse story ID from deep link: $uri');
      }
    } catch (e) {
      log.error('Error parsing deep link: $e');
    }
  }

  /// Check if the URI is a story deep link
  bool _isStoryDeepLink(Uri uri) {
    if (uri.scheme == 'gringo' && uri.host == 'story') {
      return true;
    }
    if (uri.scheme == 'https' && uri.path.contains('/api/share/story/')) {
      return true;
    }
    return false;
  }

  /// Dispose resources
  void dispose() {
    _linkSubscription?.cancel();
    _linkSubscription = null;
    _deepLinkController.close();
    _isInitialized = false;
    _isNavigationReady = false;
  }
}