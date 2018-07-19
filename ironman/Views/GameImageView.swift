import UIKit

class GameImageView: UIImageView {

  override func awakeFromNib() {
    super.awakeFromNib()
    layer.borderColor = #colorLiteral(red: 0.9843137255, green: 0.7921568627, blue: 0.01176470588, alpha: 1)
    layer.borderWidth = 1
    clipsToBounds = true
    layer.cornerRadius = 10
  }
}
