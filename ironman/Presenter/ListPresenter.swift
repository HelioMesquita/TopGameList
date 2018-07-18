import Foundation

protocol ListPresentable: class {
  func onLoad(list: GameList)
  func onPaginate(list: GameList)
  func prepareToLoadNextPage(url: URL)
  func onError(error: RequestError)
  func setRefresher()
  func startLoading()
  func endLoading()
}

class ListPresenter {

  let interactor: Interactor<GameList>
  var delegate: ListPresentable
  private var percentageOfInfinitScroll = 0.8

  init(interactor: Interactor<GameList>, delegate: ListPresentable) {
    self.interactor = interactor
    self.delegate = delegate
    delegate.setRefresher()
  }

  func performLoadData() {
    let games = interactor.retrieveGames()
    delegate.onLoad(list: GameList(links: nil, list: games))
  }

  func performRequest() {
    delegate.startLoading()
    interactor.execute(onSuccess: { gameList in
      self.interactor.saveGames(games: gameList.list)
      self.delegate.onLoad(list: gameList)
      self.delegate.endLoading()
    }, onError: { error in
      self.delegate.onError(error: error)
      self.delegate.endLoading()
    })
  }

  func handleInfinitScroll(actualRow: Int, totalRows: Int?, paginateCondition: Double = 0.7, nextLink: URL?) {
    if let link = nextLink, let totalRows = totalRows, Double(actualRow) == Double(totalRows)*paginateCondition {
      self.delegate.prepareToLoadNextPage(url: link)
    }
  }

  func presentNextPage(nextInteractor: Interactor<GameList>?) {
    delegate.startLoading()
    nextInteractor?.execute(onSuccess: { gameList in
      self.delegate.onPaginate(list: gameList)
      self.delegate.endLoading()
    }, onError: { error in
      self.delegate.onError(error: error)
      self.delegate.endLoading()
    })
  }
}
