import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    UIApplication.shared.statusBarStyle = .lightContent
    return true
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    ConnectionStatusManager.stop()
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    ConnectionStatusManager.start()
  }
}
