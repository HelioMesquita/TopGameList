import Foundation

protocol ListPresentable: class {
  func onLoad(list: GameList)
  func onPaginate(newlist: GameList)
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

  func handleInfinitScroll(actualRow: Int, totalRows: Int, nextLink: URL?) {
    if let link = nextLink, actualRow == totalRows-3 {
      self.delegate.prepareToLoadNextPage(url: link)
    }
  }

  func presentNextPage(nextInteractor: Interactor<GameList>?) {
    delegate.startLoading()
    nextInteractor?.execute(onSuccess: { gameList in
      self.delegate.onPaginate(newlist: gameList)
      self.delegate.endLoading()
    }, onError: { error in
      self.delegate.onError(error: error)
      self.delegate.endLoading()
    })
  }
}
