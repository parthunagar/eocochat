import UIKit
import Flutter
import Firebase
import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    var flutter_native_splash = 1
    UIApplication.shared.isStatusBarHidden = false

    GeneratedPluginRegistrant.register(with: self)
    if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
 
    
    registerForNotification(application)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func registerForNotification(_ application: UIApplication) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (_, _) in
            
        }
            
            application.registerForRemoteNotifications()
        }
   
    

       
   }

  

