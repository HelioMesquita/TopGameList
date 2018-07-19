import UIKit

class CardGameCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var imageView: GameImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = UIColor.white
    clipsToBounds = true
    layer.cornerRadius = 10
  }

  func setCell(game: Game?) {
    titleLabel.text = game?.name
    imageView.setImageFrom(url: game?.imageUrl)
  }
}
