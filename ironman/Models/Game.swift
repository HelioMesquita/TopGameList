import Foundation

struct Game: Decodable {
  let name: String
  let popularity: Double
  let id: Double
  let giantbombID: Double
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
