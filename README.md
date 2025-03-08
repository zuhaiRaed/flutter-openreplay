# openreplay_sdk

A Flutter Plugin for OpenReplay that Developed for training purposes

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# OpenReplay iOS SDK Initialization

## Step 1: Install the iOS SDK in the project
1. Go to the `Podfile` and under the `target 'Runner' do` block, add:
```ruby
target 'Runner' do
  use_frameworks!
  pod 'Openreplay', :git => 'https://github.com/openreplay/ios-tracker.git', :tag => '1.0.13'
end
```

## Step 2: Modify `AppDelegate.swift`
Add the following code to your `AppDelegate.swift` file:
```swift
import Flutter
import UIKit
import Openreplay

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    Openreplay.shared.serverURL = "https://app.openreplay.com/ingest"
    Openreplay.shared.start(projectKey: "rGElsCaJ71nXaml8HsHu", options: .defaults)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

## Step 3: Initialize in Dart
In your Dart code, add the following to the `main` function:
```dart
await OpenReplayService().initialize('rGElsCaJ71nXaml8HsHu');
```

## Step 4: Wrap the MaterialApp
Wrap your `MaterialApp` with the `OpenReplayWrapper`:
```dart
OpenReplayWrapper(
  child: MaterialApp(
    title: 'OpenReplay Demo',
    // Your existing MaterialApp configuration
  ),
);
