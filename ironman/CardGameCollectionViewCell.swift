import UIKit

class CardGameCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = UIColor.white
    titleLabel.textColor = UIColor.black
    clipsToBounds = true

    layer.cornerRadius = 8
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 8)
    layer.shadowOpacity = 0.08
    layer.shadowRadius = 8
    layer.masksToBounds = false

    imageView.layer.cornerRadius = 8
    imageView.clipsToBounds = true
  }

  func setCell() {
    titleLabel.text = "Counter-Strike: Global Offensive"
    let url = URL(string: "https://images-na.ssl-images-amazon.com/images/I/81L8-mjNlrL._SX385_.jpg")!
    imageView.setImageFrom(url: url) { [weak self] in
      self?.titleLabel.textColor = UIColor.white
    }
  }
}
