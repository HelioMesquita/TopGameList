import CoreData

class GameDBDataStoreManager {

  let entityName: String = "GameDB"

  func saveGames(games: [Game]) {
    clearGames()

    for game in games {
      let gameDB = GameDB(context: DataStoreManager.context)
      gameDB.channels = Int32(game.channels)
      gameDB.imageLink = game.imageUrl.absoluteString
      gameDB.viewers = Int32(game.viewers)
      gameDB.name = game.name
      DataStoreManager.saveContext()
    }
  }

  func clearGames() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    try! DataStoreManager.context.execute(deleteRequest)
  }

  func retrieveGames() -> [Game] {
    let fetchRequest: NSFetchRequest<GameDB> = GameDB.fetchRequest()
    let gameDBList = try! DataStoreManager.context.fetch(fetchRequest)

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
