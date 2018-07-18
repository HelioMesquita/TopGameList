import Foundation

class URLConfig {

  var url: URL
  var items: Array<URLQueryItem>

  init(url: URL, queryParams: [URLQueryItem]) {
    self.url = url
    self.items = URLComponents(url: self.url, resolvingAgainstBaseURL: false)!.queryItems ?? []
    self.items += queryParams
  }

  func toURLComponents() -> URLComponents {
    var urlComponents = URLComponents(url: self.url, resolvingAgainstBaseURL: false)!
    urlComponents.queryItems = items
    return urlComponents
  }
}
