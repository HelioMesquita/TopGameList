import Foundation

struct Game: Decodable {
  let next: URL
  let popularity: Int
  let id: Int
  let giantbombID: Int
  let box: ImageLinks
  let logo: ImageLinks
  let localizedName: String
  let locale: String

  enum CodingKeys: String, CodingKey {
    case name = "name"
    case popularity = "popularity"
    case id = "_id"
    case giantbombID = "giantbomb_id"
    case box = "box"
    case logo = "logo"
    case localizedName = "localized_name"
    case locale = "locale"
  }
}
