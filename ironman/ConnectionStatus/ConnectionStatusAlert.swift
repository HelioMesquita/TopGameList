import UIKit
import Whisper

struct ConnectionStatusAlert {

  static func show() {
    let murmur = Murmur(title: "No Connection", backgroundColor: UIColor.red, titleColor: UIColor.white)
    Whisper.show(whistle: murmur, action: .present)
  }

  static func hide() {
    Whisper.hide()
  }
}
