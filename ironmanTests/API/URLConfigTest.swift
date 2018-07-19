import Quick
import Nimble

@testable import ironman

class URLConfigTest: QuickSpec {

  override func spec() {
    super.spec()

    var subject: URLConfig!

    describe("#init") {
      context("when receives a url with previous query params") {
        beforeEach {
          let queryItem = URLQueryItem(name: "Tony", value: "Stark")
          subject = URLConfig(url: URL(string: "www.google.com.br/api?movie=ironman3")!, queryParams: [queryItem])
        }

        it("return 2 items") {
          expect(subject.items.count).to(equal(2))
        }

        it("return link with query string") {
          expect(subject.toURLComponents().url?.absoluteString).to(equal("www.google.com.br/api?movie=ironman3&Tony=Stark"))
        }
      }

      context("when receives a url without previous query params") {
        beforeEach {
          let queryItem = URLQueryItem(name: "Tony", value: "Stark")
          subject = URLConfig(url: URL(string: "www.google.com.br/api")!, queryParams: [queryItem])
        }

        it("return 1 items") {
          expect(subject.items.count).to(equal(1))
        }

        it("return link with query string") {
          expect(subject.toURLComponents().url?.absoluteString).to(equal("www.google.com.br/api?Tony=Stark"))
        }
      }
    }

  }
}
