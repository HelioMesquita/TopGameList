import Alamofire
import Foundation

class Interactor<S> where S: Decodable {
  typealias Model = S

  var urlConfig: URLConfig

  init(urlConfig: URLConfig) {
    self.urlConfig = urlConfig
  }

  func execute(onSuccess: @escaping (Model) -> Void, onError: @escaping () -> Void) {
    Alamofire.request(urlConfig.toURLComponents()).responseJSON { (dataResponse) in
      if let data = dataResponse.data, dataResponse.result.isSuccess {
        do {
          let model = try JSONDecoder().decode(Model.self, from: data)
          onSuccess(model)
        } catch {
          onError()
        }
      }  else {
        onError()
      }
    }
  }
}
