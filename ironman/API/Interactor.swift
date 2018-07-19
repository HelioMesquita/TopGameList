import Alamofire
import Foundation

class Interactor<S> where S: Decodable {
  typealias Model = S

  var urlConfig: URLConfig

  init(urlConfig: URLConfig) {
    self.urlConfig = urlConfig
  }

  func execute(onSuccess: @escaping (Model) -> Void, onError: @escaping (RequestError) -> Void) {
    if !ConnectionStatusManager.hasConnection() {
      onError(RequestError(error: "No Connection", status: 0, message: "Please, check network connection"))
      return
    }

    Alamofire.request(urlConfig.toURLComponents()).responseJSON { (dataResponse) in

      if let data = dataResponse.data, dataResponse.result.isSuccess {
        do {
          if let model = try? JSONDecoder().decode(Model.self, from: data) {
            onSuccess(model)
          } else if let error = try? JSONDecoder().decode(RequestError.self, from: data) {
            onError(error)
          } else {
            throw RequestError(error: "Impossible to reach the error", status: 0, message: "Try again later")
          }
        } catch {
          onError(error as! RequestError)
        }
      } else {
        onError(RequestError(error: "Missing Data", status: 0, message: "Try again later"))
      }
    }
  }
}
