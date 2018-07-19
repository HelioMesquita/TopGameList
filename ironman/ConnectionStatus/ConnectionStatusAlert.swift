import UIKit
import Whisper

struct ConnectionStatusAlert {

  static func show() {
    let murmur = Murmur(title: "No Connection", backgroundColor: #colorLiteral(red: 0.4039215686, green: 0.7803921569, blue: 0.9215686275, alpha: 1), titleColor: UIColor.white)
    Whisper.show(whistle: murmur, action: .present)
  }

  static func hide() {
    Whisper.hide()
  }
}
