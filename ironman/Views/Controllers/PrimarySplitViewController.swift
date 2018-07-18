import UIKit

class PrimarySplitViewController: UISplitViewController, UISplitViewControllerDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
    self.preferredDisplayMode = .allVisible
  }

  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
    return true
  }
}
