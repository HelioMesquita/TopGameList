import UIKit

class CardGameCollectionViewCell: UICollectionViewCell {

  override func awakeFromNib() {
    super.awakeFromNib()
    layer.cornerRadius = 8
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 8)
    layer.shadowOpacity = 0.08
    layer.shadowRadius = 8
    layer.masksToBounds = false
  }
}
