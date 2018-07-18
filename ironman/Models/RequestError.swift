import Foundation

struct RequestError: Decodable, Error {
  let error: String
  let status: Double
  let message: String
}
