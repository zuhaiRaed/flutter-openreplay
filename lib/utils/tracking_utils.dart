// tracking_provider.dart
import 'package:flutter/material.dart';
import 'package:openreplay_sdk/sdk/openreplay_sdk.dart';

// A mixin containing tracking functionality
mixin TrackingMixin {
  void trackButtonPress(String buttonId,
      [Map<String, dynamic>? additionalData]) {
    if (OpenReplayFlutter.isInitialized) {
      final data = <String, String>{
        'button_id': buttonId,
        'timestamp': DateTime.now().toIso8601String(),
      };

      if (additionalData != null) {
        additionalData.forEach((key, value) {
          data[key] = value.toString();
        });
      }

      OpenReplayFlutter.trackEvent('button_press', data);
      debugPrint("Tracked button press: $buttonId");
    } else {
      debugPrint("Cannot track button press - OpenReplay not initialized");
    }
  }

  void trackScreenView(String screenName,
      [Map<String, dynamic>? additionalData]) {
    if (OpenReplayFlutter.isInitialized) {
      final data = {
        'screen': screenName,
        'timestamp': DateTime.now().toIso8601String(),
      };

      if (additionalData != null) {
        additionalData.forEach((key, value) {
          data[key] = value.toString();
        });
      }

      OpenReplayFlutter.trackEvent('screen_view', data);
      debugPrint("Tracked screen view: $screenName");
    } else {
      debugPrint("Cannot track screen view - OpenReplay not initialized");
    }
  }

  void trackUserAction(String action, [Map<String, dynamic>? metadata]) {
    if (OpenReplayFlutter.isInitialized) {
      final data = {
        'action': action,
        'timestamp': DateTime.now().toIso8601String(),
      };

      if (metadata != null) {
        metadata.forEach((key, value) {
          data[key] = value.toString();
        });
      }

      OpenReplayFlutter.trackEvent('user_action', data);
      debugPrint("Tracked user action: $action");
    } else {
      debugPrint("Cannot track user action - OpenReplay not initialized");
    }
  }
}

// A provider that gives access to tracking throughout the app
class TrackingProvider extends InheritedWidget {
  final OpenReplayService trackingService;

  const TrackingProvider({
    super.key,
    required super.child,
    required this.trackingService,
  });

  static OpenReplayService of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<TrackingProvider>();
    assert(provider != null, 'No TrackingProvider found in context');
    return provider!.trackingService;
  }

  @override
  bool updateShouldNotify(TrackingProvider oldWidget) {
    return trackingService != oldWidget.trackingService;
  }
}

// The service class that implements the tracking functionality
class OpenReplayService with TrackingMixin {
  // You can add additional methods or state here if needed
  Future<bool> initialize(String projectKey) async {
    bool initialized = await OpenReplayFlutter.initialize(
      projectKey: projectKey,
    );

    if (initialized) {
      bool sessionStarted = await OpenReplayFlutter.startSession();
      return sessionStarted;
    }

    return false;
  }

  Future<bool> stopTracking() async {
    return await OpenReplayFlutter.stopSession();
  }
}

// A convenience widget that wraps your app with the tracking provider
class OpenReplayWrapper extends StatefulWidget {
  final Widget child;
  // final String projectKey;

  const OpenReplayWrapper({
    super.key,
    required this.child,
  });

  @override
  State<OpenReplayWrapper> createState() => _OpenReplayWrapperState();
}

class _OpenReplayWrapperState extends State<OpenReplayWrapper> {
  late OpenReplayService _trackingService;
  // bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _trackingService = OpenReplayService();
    // _initializeTracking();
  }

  @override
  Widget build(BuildContext context) {
    return TrackingProvider(
      trackingService: _trackingService,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _trackingService.stopTracking();
    super.dispose();
  }
}
