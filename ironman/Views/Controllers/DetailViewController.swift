import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var channelLabel: UILabel!
  @IBOutlet weak var viewersLabel: UILabel!
  @IBOutlet weak var noDetailsLabel: UILabel!

  var top: Top?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.offwhite
    setView()
  }

  func setView() {
    if let top = top {
      noDetailsLabel.isHidden = true
      nameLabel.text = top.game.name
      imageView.setImageFrom(url: top.game.box.large, onSuccess: {})
      channelLabel.text = String(top.channels)
      viewersLabel.text = String(top.viewers)
    } else {
      noDetailsLabel.isHidden = false
      noDetailsLabel.backgroundColor = UIColor.offwhite
      noDetailsLabel.text = "No details to show"
    }
  }
}
