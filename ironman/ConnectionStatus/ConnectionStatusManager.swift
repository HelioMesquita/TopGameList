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
    case .cellular, .wifi:
      ConnectionStatusAlert.hide()
    case .none:
      ConnectionStatusAlert.show()
    }
  }

  static func hasConnection() -> Bool {
    return shared.reachability.connection != .none
  }

  static func start() -> Void {
    try! shared.reachability.startNotifier()
  }

  static func stop() {
    NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
    shared.reachability.stopNotifier()
  }
}
