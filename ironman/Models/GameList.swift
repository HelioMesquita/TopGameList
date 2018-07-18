import Foundation

struct GameList: Decodable {
  var links: Links?
  var list: [Game] = []

  enum CodingKeys: String, CodingKey {
    case links = "_links"
    case list = "top"
  }

  func update(newlist: GameList) -> GameList {
    let newlinks = Links(next: newlist.links?.next, this: self.links?.this)
    let newList = self.list + newlist.list
    return GameList(links: newlinks, list: newList)
  }
}
