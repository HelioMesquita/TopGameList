import UIKit

class NavigationController: UINavigationController {

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.isTranslucent = false
    navigationBar.barTintColor = UIColor.darkCandyAppleRed
    navigationBar.barStyle = .blackOpaque
    navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    navigationBar.tintColor = UIColor.white
  }
}
