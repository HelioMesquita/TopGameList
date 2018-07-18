import Foundation

struct Game: Decodable {
  private let info: GameInfo
  let viewers: Int
  let channels: Int

  var name: String {
    return info.name
  }

  var imageUrl: URL {
    return info.box.large
  }

  init(viewers: Int, channels: Int, imageUrl: URL, name: String) {
    self.viewers = viewers
    self.channels = channels
    let imageLink = ImageLink(large: imageUrl)
    let info = GameInfo(name: name, box: imageLink)
    self.info = info
  }

  enum CodingKeys: String, CodingKey {
    case info = "game"
    case viewers
    case channels
  }
}
