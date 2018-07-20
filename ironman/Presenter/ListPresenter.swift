import Foundation

protocol ListPresentable: class {
  func onLoad(list: GameList)
  func reloadData()
  func onPaginate(newList: GameList)
  func prepareToLoadNextPage(url: URL)
  func onError(error: RequestError)
  func setRefresher()
  func startLoading()
  func endLoading()
}

class ListPresenter {

  let interactor: Interactor<GameList>
  let dataStore: GameDBDataStoreManagable
  let delegate: ListPresentable

  init(interactor: Interactor<GameList>, delegate: ListPresentable, dataStore: GameDBDataStoreManagable) {
    self.interactor = interactor
    self.delegate = delegate
    self.dataStore = dataStore
    delegate.setRefresher()
  }

  func performLoadData() {
    let games = dataStore.retrieveGames()
    delegate.onLoad(list: GameList(links: nil, list: games))
  }

  func performRequest() {
    delegate.startLoading()
    interactor.execute(onSuccess: { gameList in
      self.dataStore.saveGames(games: gameList.list)
      self.delegate.onLoad(list: gameList)
      self.delegate.reloadData()
      self.delegate.endLoading()
    }, onError: { error in
      self.delegate.endLoading()
      self.delegate.onError(error: error)
    })
  }

  func handleInfinitScroll(currentRow: Int, totalRows: Int, nextLink: URL?) {
    if let link = nextLink, currentRow == totalRows-5 {
      self.delegate.prepareToLoadNextPage(url: link)
    }
  }

  func presentNextPage(nextInteractor: Interactor<GameList>?) {
    nextInteractor?.execute(onSuccess: { gameList in
      self.delegate.onPaginate(newList: gameList)
    }, onError: { error in
      self.delegate.onError(error: error)
    })
  }

  func handlePaginate(currentList: [Game], newList: [Game], section: Int) -> [IndexPath] {
    let elements = Array(currentList.count...newList.count+currentList.count-1)
    return elements.map { IndexPath(item: $0, section: 0) }
  }
}
