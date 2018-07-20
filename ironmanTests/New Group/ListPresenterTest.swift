import Quick
import Nimble

@testable import ironman

class ListPresenterTest: QuickSpec {

  class DummyGameDB: GameDBDataStoreManager {

    var hasSaved = false
    var hasCleared = false
    var hasRetrived = false

    override func saveGames(games: [Game]) { hasSaved = true }
    override func clearGames() { hasCleared = true}
    override func retrieveGames() -> [Game] {
      hasRetrived = true
      return [Game(viewers: 0, channels: 0, imageUrl: URL(string: "www.google.com.br")!, name: "Iron Man")]
    }
  }


  class DummyInteractor<S>: Interactor<S> where S: Decodable {
    var isAPIResponseSuccess = true
    var successModel: S
    var errorModel: RequestError

    init(successModel: S, errorModel: RequestError) {
      self.successModel = successModel
      self.errorModel = errorModel
      let urlConfig = URLConfig(url: URL(string: "www.google.com.br/")!, queryParams: [])
      super.init(urlConfig: urlConfig)
    }

    override func execute(hasConnection: Bool, onSuccess: @escaping (S) -> Void, onError: @escaping (RequestError) -> Void) {
      if isAPIResponseSuccess {
        onSuccess(successModel)
      } else {
        onError(errorModel)
      }
    }
  }

  class DummyListViewController: ListPresentable {
    var hasLoaded = false
    var hasPaginated = false
    var preparedToLoad = false
    var hasError = false
    var refresherSet = false
    var statedLoading = false
    var endedLoading = false

    func onLoad(list: GameList) { hasLoaded = true }
    func onPaginate(newList: GameList) { hasPaginated = true }
    func prepareToLoadNextPage(url: URL) { preparedToLoad = true }
    func onError(error: RequestError) { hasError = true }
    func setRefresher() { refresherSet = true }
    func startLoading() { statedLoading = true }
    func endLoading() { endedLoading = true }
  }

  override func spec() {
    super.spec()

    let link = URL(string: "www.google.com.br")!
    let game  = Game(viewers: 0, channels: 0, imageUrl: link, name: "Iron Man")
    let gameList = GameList(links: Links(next: URL(string: "www.uol.com.br"), this: nil), list: [game])
    let requestError = RequestError(error: "Loky appears", status: 0, message: "Fight")
    var dummyViewController: DummyListViewController!
    var interactor: DummyInteractor<GameList>!
    var subject: ListPresenter!

    beforeEach {
      dummyViewController = DummyListViewController()
      interactor = DummyInteractor<GameList>(successModel: gameList, errorModel: requestError)
      subject = ListPresenter(interactor: interactor, delegate: dummyViewController, dataStore: DummyGameDB())
    }

    describe("#init") {
      context("when initialize the presenter") {
        it("returns true") {
          expect(dummyViewController.refresherSet).to(beTrue())
        }
      }
    }

    describe("#performRequest") {
      context("when the request is successfull on load is called") {
        beforeEach {
          interactor.isAPIResponseSuccess = true
          subject.performRequest()
        }
        it("returns true") {
          expect(dummyViewController.hasLoaded).to(beTrue())
        }
        it("returns true") {
          expect(dummyViewController.statedLoading).to(beTrue())
        }
        it("returns true") {
          expect(dummyViewController.endedLoading).to(beTrue())
        }
      }

      context("when the request is unsuccessfull on error is called") {
        beforeEach {
          interactor.isAPIResponseSuccess = false
          subject.performRequest()
        }
        it("returns true") {
          expect(dummyViewController.hasError).to(beTrue())
        }
        it("returns true") {
          expect(dummyViewController.statedLoading).to(beTrue())
        }
        it("returns true") {
          expect(dummyViewController.endedLoading).to(beTrue())
        }
      }
    }

    describe("#handlePaginate") {
      context("when insert new rows in collection view, get the indexpath of new rows") {
        it("returns indexpath") {
          let game  = Game(viewers: 0, channels: 0, imageUrl: URL(string: "www.google.com.br")!, name: "Iron Man")
          let value = subject.handlePaginate(currentList: [game], newList: [game, game], section: 0)

          expect(value.count).to(equal(2))
        }
      }
    }

    describe("#performLoadData") {
      context("when get storage data") {
        it("returns true") {
          subject.performLoadData()

          expect(dummyViewController.hasLoaded).to(beTrue())
        }
      }
    }

    describe("#handleInfinitScroll") {
      context("when will display row checking to be total of rows less 3") {
        context("with next link and 7 of 10") {
          beforeEach {
            subject.handleInfinitScroll(currentRow: 7, totalRows: 10, nextLink: link)
          }
          it("returns true") {
            expect(dummyViewController.preparedToLoad).to(beTrue())
          }
        }

        context("with next link and 6 of 10") {
          beforeEach {
            subject.handleInfinitScroll(currentRow: 6, totalRows: 10, nextLink: link)
          }
          it("returns false") {
            expect(dummyViewController.preparedToLoad).to(beFalse())
          }
        }

        context("without next link and 6 of 10") {
          beforeEach {
            subject.handleInfinitScroll(currentRow: 7, totalRows: 10, nextLink: nil)
          }
          it("returns false") {
            expect(dummyViewController.preparedToLoad).to(beFalse())
          }
        }
      }
    }

    describe("#presentNextPage") {
      context("when the request is successfull on paginate is called") {
        beforeEach {
          interactor.isAPIResponseSuccess = true
          subject.presentNextPage(nextInteractor: interactor)
        }
        it("returns true") {
          expect(dummyViewController.hasPaginated).to(beTrue())
        }
        it("returns true") {
          expect(dummyViewController.statedLoading).to(beTrue())
        }
        it("returns true") {
          expect(dummyViewController.endedLoading).to(beTrue())
        }
      }

      context("when the request is unsuccessfull on error is called") {
        beforeEach {
          interactor.isAPIResponseSuccess = false
          subject.presentNextPage(nextInteractor: interactor)
        }
        it("returns true") {
          expect(dummyViewController.statedLoading).to(beTrue())
        }
        it("returns true") {
          expect(dummyViewController.endedLoading).to(beTrue())
        }
        it("returns true") {
          expect(dummyViewController.hasError).to(beTrue())
        }
      }
    }
  }
}
