import UIKit
import Whisper

struct ConnectionStatusAlert {

  static func show() {
    let murmur = Murmur(title: "No Connection", backgroundColor: UIColor.mayaBlue, titleColor: UIColor.white)
    Whisper.show(whistle: murmur, action: .present)
  }

  static func hide() {
    Whisper.hide()
  }
}
