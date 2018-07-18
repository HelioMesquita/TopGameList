import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var channelLabel: UILabel!
  @IBOutlet weak var viewersLabel: UILabel!
  @IBOutlet weak var noDetailsLabel: UILabel!

  var game: Game?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.offwhite
    setView()
  }

  func setView() {
    if let game = game {
      noDetailsLabel.isHidden = true
      nameLabel.text = game.name
      imageView.setImageFrom(url: game.imageUrl, onSuccess: {})
      channelLabel.text = String(game.channels)
      viewersLabel.text = String(game.viewers)
    } else {
      noDetailsLabel.isHidden = false
      noDetailsLabel.backgroundColor = UIColor.offwhite
      noDetailsLabel.text = "No details to show"
    }
  }
}
