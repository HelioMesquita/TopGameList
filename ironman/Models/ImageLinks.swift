import Foundation

struct ImageLinks: Decodable {
  let large: URL
  let medium: URL
  let small: URL
  let template: URL
}
