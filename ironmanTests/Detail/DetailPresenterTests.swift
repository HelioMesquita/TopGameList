import Quick
import Nimble

@testable import ironman

class DetailPresenterTests: QuickSpec {

  class DummyViewController: DetailPresentable {
    var hasShowedDetail = false

    func showDetail(game: Game) { hasShowedDetail = true }
  }

  override func spec() {
    super.spec()

    var dummyViewController: DummyViewController!

    beforeEach {
      dummyViewController = DummyViewController()
    }

    describe("#present") {
      context("when open the app and the game is nil") {
        it("return false") {
          DetailPresenter(game: nil, delegate: dummyViewController).present()

          expect(dummyViewController.hasShowedDetail).to(beFalse())
        }
      }
      context("when has game") {
        it("return true") {
          let game = Game(viewers: 0, channels: 0, imageUrl: URL(string: "www.google.com.br")!, name: "Iron Man")
          DetailPresenter(game: game, delegate: dummyViewController).present()

          expect(dummyViewController.hasShowedDetail).to(beTrue())
        }
      }
    }
  }
}
