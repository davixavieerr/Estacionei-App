import UIKit
import Flutter
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // CHAVE DE API DO GOOGLE MAPS CONFIGURADA PARA IOS:
    GMSServices.provideAPIKey("AIzaSyAiRnYGDzYtvKRaTsR6O6EaekbpkEgGn3Y")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
