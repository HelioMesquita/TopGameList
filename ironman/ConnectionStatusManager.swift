import Foundation
import Reachability

class ConnectionStatusManager: NSObject {

  var reachability: Reachability!

  static let sharedInstance: ConnectionStatusManager = { return ConnectionStatusManager() }()

  override init() {
    super.init()

    reachability = Reachability()!

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(networkStatusChanged(_:)),
      name: .reachabilityChanged,
      object: reachability
    )

    do {
      try reachability.startNotifier()
    } catch {
      print("Unable to start notifier")
    }
  }

  @objc func networkStatusChanged(_ notification: Notification) {
    let reachability = notification.object as! Reachability
    switch reachability.connection {
    case .cellular:
      debugPrint("Network reachable through Cellular Data")
    case .none:
      debugPrint("Network became unreachable")
    case .wifi:
      debugPrint("Network reachable through WiFi")
    }
  }

  static func stopNotifier() -> Void {
    do {
      try (ConnectionStatusManager.sharedInstance.reachability).startNotifier()
    } catch {
      print("Error stopping notifier")
    }
  }

//  static func isReachable(completed: @escaping (ConnectionStatusManager) -> Void) {
//    if (ConnectionStatusManager.sharedInstance.reachability).connection != .none {
//      completed(ConnectionStatusManager.sharedInstance)
//    }
//  }
//
//  static func isUnreachable(completed: @escaping (ConnectionStatusManager) -> Void) {
//    if (ConnectionStatusManager.sharedInstance.reachability).connection == .none {
//      completed(ConnectionStatusManager.sharedInstance)
//    }
//  }
//
//  static func isReachableViaWWAN(completed: @escaping (ConnectionStatusManager) -> Void) {
//    if (ConnectionStatusManager.sharedInstance.reachability).connection == .cellular {
//      completed(ConnectionStatusManager.sharedInstance)
//    }
//  }
//
//  static func isReachableViaWiFi(completed: @escaping (ConnectionStatusManager) -> Void) {
//    if (ConnectionStatusManager.sharedInstance.reachability).connection == .wifi {
//      completed(ConnectionStatusManager.sharedInstance)
//    }
//  }
}

