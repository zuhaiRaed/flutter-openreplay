// navigation_tracking.dart
import 'package:flutter/material.dart';
import 'package:openreplay_sdk/openreplay_flutter.dart';

/// A NavigatorObserver that automatically tracks screen views in OpenReplay
class OpenReplayNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _trackScreen(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _trackScreen(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _trackScreen(previousRoute);
    }
  }

  void _trackScreen(Route<dynamic> route) {
    // Get route name or use route.settings.name if available
    String screenName = route.settings.name ?? _getRouteName(route);
    
    if (OpenReplayFlutter.isInitialized) {
      OpenReplayFlutter.trackEvent('screen_view', {
        'screen': screenName,
        'timestamp': DateTime.now().toIso8601String(),
      });
      debugPrint("Navigation tracked: $screenName");
    } else {
      debugPrint("Cannot track navigation - OpenReplay not initialized");
    }
  }
  
  // Helper method to determine a meaningful name for routes without explicit names
  String _getRouteName(Route<dynamic> route) {
    // Try to get a meaningful name from the route
    if (route is MaterialPageRoute) {
      return route.builder.runtimeType.toString();
    } else if (route is PageRouteBuilder) {
      return 'PageRouteBuilder';
    } else {
      return route.runtimeType.toString();
    }
  }
}

/// Usage example:
/// 
/// MaterialApp(
///   navigatorObservers: [
///     OpenReplayNavigatorObserver(),
///   ],
///   // rest of your MaterialApp configuration
/// )