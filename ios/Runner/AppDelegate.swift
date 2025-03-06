import UIKit
import Flutter
import Firebase 
import MintFrameworks
import IQKeyboardManagerSwift
//import IQKeyboardToolbarManager

@main
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()
      GeneratedPluginRegistrant.register(with: self)
      Messaging.messaging().delegate = self
      
      Messaging.messaging().token { token, error in
        if let error = error {
          print("Error fetching FCM registration token: \(error)")
        } else if let token = token {
            print("FCM registration token: \(token)")
        }
      }
    
      
    if #available(iOS 10.0, *) {
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
    } else {
        let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
    }
    application.registerForRemoteNotifications()
      
      IQKeyboardManager.shared.enable = true
//        IQKeyboardToolbarManager.shared.isEnabled = true
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
              } else {
                  result(FlutterMethodNotImplemented)
              }
          })

     
    
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    @objc func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//         print( "fcmToken ==== " , fcmToken)
    }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent Response Info :\(notification.request.content.userInfo)")
        if #available(iOS 14.0, *) {
            completionHandler([.banner, .badge, .sound])
        }else{
            completionHandler([.alert, .badge, .sound])
        }
        
    }
    
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("didReceiveRemoteNotification Response Info :\(userInfo)")
    }
    
    private func invokeMintSDK(ssoToken: String, fcmToken: String, domain: String) {
       if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
           MintSDKInvoke().invokeMintAppFormFlutterApp(domain: domain, token: ssoToken, navigateToview: "", controller: rootViewController)
       }
     }
}
