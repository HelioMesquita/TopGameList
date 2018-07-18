import UIKit

class DetailViewController: UIViewController {

  var top: Top!

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var channelLabel: UILabel!
  @IBOutlet weak var viewersLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.offwhite
    setView()
  }

  func setView() {
    nameLabel.text = top.game.name
    imageView.setImageFrom(url: top.game.box.large, onSuccess: {})
    channelLabel.text = String(top.channels)
    viewersLabel.text = String(top.viewers)
  }
}
