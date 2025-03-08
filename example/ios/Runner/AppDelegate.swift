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
