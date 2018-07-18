import Foundation

struct Links: Decodable {
  let next: URL?
  let this: URL?

  enum CodingKeys: String, CodingKey {
    case next
    case this = "self"
  }
}
