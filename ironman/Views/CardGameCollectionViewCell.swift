import UIKit

class CardGameCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = UIColor.white
    clipsToBounds = true
    layer.cornerRadius = 10

    titleLabel.textColor = UIColor.black
    imageView.layer.cornerRadius = 10
    imageView.clipsToBounds = true
  }

  func setCell(top: Top?) {
    titleLabel.text = top?.game.name
    imageView.setImageFrom(url: top?.game.box.large) { [weak self] in
      self?.titleLabel.textColor = UIColor.white
    }
  }
}
