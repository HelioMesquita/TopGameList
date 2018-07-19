import UIKit
import Whisper

struct ConnectionStatusAlert {

  static func show() {
    let murmur = Murmur(title: "No Connection", backgroundColor: #colorLiteral(red: 0.9843137255, green: 0.7921568627, blue: 0.01176470588, alpha: 1), titleColor: UIColor.black)
    Whisper.show(whistle: murmur, action: .present)
  }

  static func hide() {
    Whisper.hide()
  }
}
