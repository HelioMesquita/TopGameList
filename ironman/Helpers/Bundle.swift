import Foundation

extension Bundle {

  func getEntrypoint() -> URL {
    let url = self.object(forInfoDictionaryKey: "Entrypoint") as! String
    return URL(string: url)!
  }

  func getID() -> String {
    return self.object(forInfoDictionaryKey: "CliendID") as! String
  }
}
