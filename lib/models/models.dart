class OpenReplayOptions {
  final bool capturePerformance;
  final bool captureNetwork;
  final bool captureScreenshots;
  final int? maxDuration;
  final Map<String, String>? defaultMetadata;

  OpenReplayOptions({
    this.capturePerformance = true,
    this.captureNetwork = true,
    this.captureScreenshots = true,
    this.maxDuration,
    this.defaultMetadata,
  });

  Map<String, dynamic> toMap() {
    return {
      'capturePerformance': capturePerformance,
      'captureNetwork': captureNetwork,
      'captureScreenshots': captureScreenshots,
      if (maxDuration != null) 'maxDuration': maxDuration,
      if (defaultMetadata != null) 'defaultMetadata': defaultMetadata,
    };
  }
}