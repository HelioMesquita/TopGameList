import Foundation

protocol ListPresentable: class {
  func onLoad(list: GameList)
  func onPaginate(newList: GameList)
  func prepareToLoadNextPage(url: URL)
  func onError(error: RequestError)
  func setRefresher()
  func startLoading()
  func endLoading()
}

class ListPresenter {

  let interactor: Interactor<GameList>
  let dataStore: GameDBDataStoreManager
  let delegate: ListPresentable

  init(interactor: Interactor<GameList>, delegate: ListPresentable, dataStore: GameDBDataStoreManager) {
    self.interactor = interactor
    self.delegate = delegate
    self.dataStore = dataStore
    delegate.setRefresher()
  }

  func performLoadData() {
    delegate.startLoading()
    let games = dataStore.retrieveGames()
    delegate.onLoad(list: GameList(links: nil, list: games))
  }

  func performRequest() {
    delegate.startLoading()
    interactor.execute(onSuccess: { gameList in
      self.dataStore.saveGames(games: gameList.list)
      self.delegate.onLoad(list: gameList)
      self.delegate.endLoading()
    }, onError: { error in
      self.delegate.onError(error: error)
      self.delegate.endLoading()
    })
  }

  func handleInfinitScroll(currentRow: Int, totalRows: Int, nextLink: URL?) {
    if let link = nextLink, currentRow == totalRows-3 {
      self.delegate.prepareToLoadNextPage(url: link)
    }
  }

  func presentNextPage(nextInteractor: Interactor<GameList>?) {
    delegate.startLoading()
    nextInteractor?.execute(onSuccess: { gameList in
      self.delegate.onPaginate(newList: gameList)
      self.delegate.endLoading()
    }, onError: { error in
      self.delegate.onError(error: error)
      self.delegate.endLoading()
    })
  }

  func handlePaginate(currentList: [Game], newList: [Game], section: Int) -> [IndexPath] {
    let elements = Array(currentList.count...newList.count+currentList.count-1)
    return elements.map { IndexPath(item: $0, section: 0) }
  }
}
