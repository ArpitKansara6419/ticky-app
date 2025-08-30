import Flutter
import UIKit
import GoogleMaps
// import background_location_tracker

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDDVz2pXtvfL3kvQ6m5kNjDYRzuoIwSZTI")
    GeneratedPluginRegistrant.register(with: self)

//      BackgroundLocationTrackerPlugin.setPluginRegistrantCallback { registry in
//          GeneratedPluginRegistrant.register(with: registry)
//      }

    UNUserNotificationCenter.current().delegate = self
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
