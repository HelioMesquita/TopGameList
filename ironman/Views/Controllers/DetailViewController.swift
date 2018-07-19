import UIKit

class DetailViewController: UIViewController, DetailPresentable {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var channelLabel: UILabel!
  @IBOutlet weak var viewersLabel: UILabel!
  @IBOutlet weak var noDetailsLabel: UILabel!

  var game: Game?

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.937254902, blue: 0.9450980392, alpha: 1)
    noDetailsLabel.isHidden = false
    noDetailsLabel.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.937254902, blue: 0.9450980392, alpha: 1)
    noDetailsLabel.text = "No details to show"
    DetailPresenter(game: game, delegate: self).present()
  }

  func showDetail(game: Game) {
    noDetailsLabel.isHidden = true
    nameLabel.text = game.name
    imageView.setImageFrom(url: game.imageUrl)
    channelLabel.text = String(game.channels)
    viewersLabel.text = String(game.viewers)
  }
}
