import UIKit
import Whisper

struct ConnectionStatusAlert {

  let murmur: Murmur

  init(murmur: Murmur = Murmur(title: "No Connection", backgroundColor: #colorLiteral(red: 0.9843137255, green: 0.7921568627, blue: 0.01176470588, alpha: 1), titleColor: UIColor.black)) {
    self.murmur = murmur
  }

  func show() {
    Whisper.show(whistle: murmur, action: .present)
  }

  func hide() {
    Whisper.hide()
  }
}
