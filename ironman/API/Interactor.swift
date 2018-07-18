import Alamofire
import CoreData
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

      guard let data = dataResponse.data else {
        onError(RequestError(error: "Missing Data", status: 0, message: "Try again later"))
        return
      }

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
    }
  }

//  func saveTopGames(list: [Top]) {
//    for item in list {
//      let gameItem = GameItem(context: GamesDataBaseManager.context)
//      
////      gameItem.name = item.game.name
////      gameItem.imageLink = item.game.box.large.absoluteString
//      GamesDataBaseManager.saveContext()
//    }
//  }
//
//  func getTopGames() -> [Top] {
//    let fetchRequest: NSFetchRequest<GameItem> = GameItem.fetchRequest()
//    let gameList = try! GamesDataBaseManager.context.fetch(fetchRequest)
//
//    var list:[Top] = []
//
////    for game in gameList {
////      list.append(Top(game: Game(name: game.name!, popularity: nil, id: nil, giantbombID: nil, box: ImageLinks(large: URL(string: game.imageLink!)!, medium: nil, small: nil), logo: nil, localizedName: nil, locale: nil), viewers: nil, channels: nil))
////    }
//
//    return list
//  }
}
