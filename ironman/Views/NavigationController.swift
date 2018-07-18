import UIKit

class NavigationController: UINavigationController {

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.prefersLargeTitles = true
    navigationBar.isTranslucent = false
    navigationBar.barTintColor = UIColor.purpleTwitch
    navigationBar.barStyle = .blackOpaque
    navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
  }
}
