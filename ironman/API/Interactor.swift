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

  func saveGames(games: [Game]) {
    for game in games {
      let gameDB = GameItem(context: GamesDataBaseManager.context)
      gameDB.channels = Int32(game.channels)
      gameDB.imageLink = game.imageUrl.absoluteString
      gameDB.viewers = Int32(game.viewers)
      gameDB.name = game.name
      GamesDataBaseManager.saveContext()
    }
  }

  func clearGames() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameItem")
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    try! GamesDataBaseManager.context.execute(deleteRequest)
  }

  func retrieveGames() -> [Game] {
    let fetchRequest: NSFetchRequest<GameItem> = GameItem.fetchRequest()
    let gameDBList = try! GamesDataBaseManager.context.fetch(fetchRequest)

    var games: [Game] = []

    for gameDB in gameDBList {
      let game = Game(viewers: Int(gameDB.viewers),
                      channels: Int(gameDB.channels),
                      imageUrl: URL(string: gameDB.imageLink!)!,
                      name: gameDB.name!)

      games.append(game)
    }

    return games
  }
}
