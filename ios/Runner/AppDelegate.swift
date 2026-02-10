import UIKit
import Flutter
import MintFrameworks
import IQKeyboardManagerSwift
import IQKeyboardToolbarManager

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    IQKeyboardManager.shared.isEnabled = true
  IQKeyboardToolbarManager.shared.isEnabled = true
    // let controller : FlutterViewController = navigationController.topViewController as! FlutterViewController
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let mintChannel = FlutterMethodChannel(name: "mint-android-app", binaryMessenger: controller.binaryMessenger)
    mintChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if call.method == "openMintLibIOS" {
            guard let args = call.arguments as? [String: Any],
                  let ssoToken = args["ssoToken"] as? String,
                  let fcmToken = args["fcmToken"] as? String,
                  let domain = args["domain"] as? String else {
                result(FlutterError(code: "INVALID_ARGS",
                                    message: "Invalid arguments",
                                    details: nil))
                return
            }
            self.invokeMintSDK(ssoToken: ssoToken, fcmToken: fcmToken, domain: domain)
            result("Success")
        } else if call.method == "isValidAuth"{
            result(MintSDKInvoke().isSessionAvailable())
        }else if call.method == "clearSession"{
            result(MintSDKInvoke().clearSDKSession())
        }else if call.method == "clearSessionIos"{
            result(MintSDKInvoke().clearSDKSession())
        }
        else {
            result(FlutterMethodNotImplemented)
        }
    })
      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  private func invokeMintSDK(ssoToken: String, fcmToken: String, domain: String) {
    if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
        MintSDKInvoke().invokeMintAppFormFlutterApp(domain: domain, token: ssoToken, navigateToview: "", controller: rootViewController,colorPrimary:"#2042FE",colorToolbar:"#FFFFFF",launchIcon: nil)
    }
  }
}
