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

  enum CodingKeys: String, CodingKey {
    case info = "game"
    case viewers
    case channels
  }
}
