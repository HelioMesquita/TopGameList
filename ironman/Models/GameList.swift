import Foundation

struct GameList: Decodable {
  var total: Int = 0
  var links: Links?
  var top: [Top]

  enum CodingKeys: String, CodingKey {
    case total = "_total"
    case links = "_links"
    case top
  }

  func update(newlist: GameList) -> GameList {
    return GameList(total: newlist.total, links: Links(next: newlist.links?.next, this: self.links?.this), top: self.top + newlist.top)
  }
}
