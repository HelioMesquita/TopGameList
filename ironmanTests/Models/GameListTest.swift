import Quick
import Nimble

@testable import ironman

class GameListTest: QuickSpec {

  override func spec() {
    super.spec()

    var subject: GameList!

    describe("#update") {
      context("when receives more games from next page") {

        beforeEach {
          let game  = Game(viewers: 0, channels: 0, imageUrl: URL(string: "www.google.com.br")!, name: "Iron Man")
          let game2 = Game(viewers: 0, channels: 0, imageUrl: URL(string: "www.google.com.br")!, name: "Spider Man")
          let game3 = Game(viewers: 0, channels: 0, imageUrl: URL(string: "www.google.com.br")!, name: "Thor")
          let game4 = Game(viewers: 0, channels: 0, imageUrl: URL(string: "www.google.com.br")!, name: "Captain America")
          let gameList = GameList(links: Links(next: URL(string: "www.uol.com.br"), this: nil), list: [game, game2])
          let gameList2 = GameList(links: Links(next: URL(string: "www.google.com.br"), this: nil), list: [game3, game4])
          subject = gameList.update(newlist: gameList2)
        }

        it("return 4 games") {
          expect(subject.list.count).to(equal(4))
        }

        it("returns google url as next link") {
          expect(subject.links?.next?.absoluteString).to(equal("www.google.com.br"))
        }
      }
    }
  }
}
