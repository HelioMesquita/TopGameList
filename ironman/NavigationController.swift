import UIKit

class NavigationController: UINavigationController {

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.isTranslucent = false
    navigationBar.barTintColor = UIColor.purpleTwitch
    navigationBar.barStyle = .blackOpaque
  }
}
