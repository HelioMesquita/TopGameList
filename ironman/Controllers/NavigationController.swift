import UIKit

class NavigationController: UINavigationController {

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.isTranslucent = false
    navigationBar.barTintColor = #colorLiteral(red: 0.6666666667, green: 0.01960784314, blue: 0.01960784314, alpha: 1)
    navigationBar.barStyle = .blackOpaque
    navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    navigationBar.tintColor = UIColor.white
  }
}
