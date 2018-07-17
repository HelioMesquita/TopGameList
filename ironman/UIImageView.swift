import UIKit
import SDWebImage

extension UIImageView {

  func setImageFrom(url: URL?, placeHolder: UIImage? = nil, onSuccess: @escaping () -> Void) {
    self.sd_setImage(with: url, placeholderImage: placeHolder) { (_, error, _, _) in
      if error == nil {
        onSuccess()
      }
    }
  }
}
