// Extension for OpenReplayFlutter to expose initialization state
import 'package:flutter/widgets.dart';
import 'package:openreplay_sdk/sdk/openreplay_sdk.dart';
import 'package:openreplay_sdk/utils/tracking_utils.dart';

extension OpenReplayFlutterExtension on OpenReplayFlutter {
  // Add a static getter for the initialization state
  static bool get isInitialized => OpenReplayFlutter.isInitialized;
}

// Extension methods for tracking on BuildContext
extension TrackingContextExtension on BuildContext {
  // Get the tracking service from anywhere you have a BuildContext
  OpenReplayService get tracking => TrackingProvider.of(this);

  // Shorthand methods for common tracking actions
  void trackButtonPress(String buttonId, [Map<String, dynamic>? data]) {
    tracking.trackButtonPress(buttonId, data);
  }

  void trackScreenView(String screenName, [Map<String, dynamic>? data]) {
    tracking.trackScreenView(screenName, data);
  }

  void trackUserAction(String action, [Map<String, dynamic>? data]) {
    tracking.trackUserAction(action, data);
  }
}

// Extension methods for tracking on Widget (for StatelessWidgets)
extension TrackingWidgetExtension on Widget {
  // Wrap widget with tracking functionality
  Widget withTracking(
      {required String actionId,
      required Function() onTap,
      Map<String, dynamic>? metadata}) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            context.trackButtonPress(actionId, metadata);
            onTap();
          },
          child: this,
        );
      },
    );
  }
}

// Extension for auto-tracking screen views in StatefulWidgets
mixin AutoTrackScreenView<T extends StatefulWidget> on State<T> {
  String get screenName;
  Map<String, dynamic>? get screenMetadata => null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Track screen view when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.trackScreenView(screenName, screenMetadata);
    });
  }
}
