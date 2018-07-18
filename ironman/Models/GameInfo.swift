import Foundation

struct GameInfo: Decodable {
  let name: String
  let box: ImageLink

  enum CodingKeys: String, CodingKey {
    case name = "name"
    case box = "box"
  }
}
