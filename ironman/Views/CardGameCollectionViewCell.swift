import UIKit

class CardGameCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = UIColor.white
    clipsToBounds = true
    layer.cornerRadius = 10

    titleLabel.textColor = UIColor.white
    imageView.layer.cornerRadius = 10
    imageView.clipsToBounds = true
  }

  func setCell(game: Game?) {
    titleLabel.text = game?.name
    imageView.setImageFrom(url: game?.imageUrl)
  }
}
