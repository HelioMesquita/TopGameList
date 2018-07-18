import Foundation

struct GameList: Decodable {
  let total: Int = 0
  let links: Links?
  let top: [Top]

  enum CodingKeys: String, CodingKey {
    case total = "_total"
    case links = "_links"
    case top
  }
}
