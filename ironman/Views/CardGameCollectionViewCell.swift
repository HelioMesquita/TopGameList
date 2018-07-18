import UIKit

class CardGameCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = UIColor.white
    titleLabel.textColor = UIColor.black
    clipsToBounds = true

    layer.cornerRadius = 10
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 8)
    layer.shadowOpacity = 0.08
    layer.shadowRadius = 8
    layer.masksToBounds = false

    imageView.layer.cornerRadius = 10
    imageView.clipsToBounds = true
  }

  func setCell(top: Top?) {
    titleLabel.text = top?.game.name
    imageView.setImageFrom(url: top?.game.box.medium) { [weak self] in
      self?.titleLabel.textColor = UIColor.white
    }
  }
}
