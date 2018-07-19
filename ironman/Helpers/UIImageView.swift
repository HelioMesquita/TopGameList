import UIKit
import SDWebImage

extension UIImageView {

  func setImageFrom(url: URL?) {
    self.sd_setImage(with: url)
  }
}
