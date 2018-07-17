import Foundation
import Reachability

class ConnectionStatusManager: NSObject {

  var reachability: Reachability!

  static let shared: ConnectionStatusManager = { return ConnectionStatusManager() }()

  override init() {
    super.init()

    reachability = Reachability()!
    NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: .reachabilityChanged, object: reachability)
    try! reachability.startNotifier()
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

  static func start() -> Void {
    try! shared.reachability.startNotifier()
  }

  static func stop() {
    NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
    shared.reachability.stopNotifier()
  }
}

