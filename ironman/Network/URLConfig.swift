import Foundation

class URLConfig {

  var url: URL
  var items: Array<URLQueryItem>

  init(url: URL = Bundle.main.getEntrypoint(), name: String = "client_id", value: String = Bundle.main.getID()) {
    self.url = url
    self.items = URLComponents(url: self.url, resolvingAgainstBaseURL: false)!.queryItems ?? []
    self.items.append(URLQueryItem(name: name, value: value))
  }

  func toURLComponents() -> URLComponents {
    var urlComponents = URLComponents(url: self.url, resolvingAgainstBaseURL: false)!
    urlComponents.queryItems = items
    return urlComponents
  }
}
