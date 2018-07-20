import Quick
import Nimble
import Mockingjay

@testable import ironman

class InteractorTests: QuickSpec {

  class DummyModel: Decodable {
    let title: String
    let message: String
  }

  override func spec() {
    super.spec()

    let href = "www.google.com.br/"
    let validResponse: [String : Any] = ["title": "title from mock json", "message": "message from mock json"]
    let invalidResponse: [String : Any] = ["error": "title invalid", "status": 13, "message": "message invalid"]
    let errorResponse = ["value": "problem in api"]
    let urlConfig = URLConfig(url: URL(string: href)!, queryParams: [])
    var resultDummy: DummyModel?
    var subject: Interactor<DummyModel>!
    var requestError: RequestError?

    beforeEach {
      subject = Interactor<DummyModel>(urlConfig: urlConfig)
    }

    describe("interactor") {
      describe("#execute") {
        context("right parser") {
          beforeEach {
            self.stub(everything, json(validResponse))
          }
          it("returns a json parsed") {
            subject.execute(onSuccess: { result in
              resultDummy = result
            }, onError: { error in
              XCTFail()
            })
            expect(resultDummy?.title).toEventually(equal("title from mock json"), timeout: 5.5, pollInterval: 0.5)
            expect(resultDummy?.message).toEventually(equal("message from mock json"), timeout: 5.5, pollInterval: 0.5)
          }
        }
        context("wrong parser") {
          beforeEach {
            self.stub(everything, json(errorResponse))
          }
          it("returns a fail message") {
            subject.execute(onSuccess: { result in
              XCTFail()
            }, onError: { error in
              requestError = error
            })
            expect(requestError?.message).toEventually(equal("Try again later"), timeout: 5.5, pollInterval: 0.5)
            expect(requestError?.status).toEventually(equal(0), timeout: 5.5, pollInterval: 0.5)
            expect(requestError?.error).toEventually(equal("Impossible to reach the error"), timeout: 5.5, pollInterval: 0.5)
          }
        }
        context("request error parser") {
          beforeEach {
            self.stub(everything, json(invalidResponse))
          }
          it("returns a fail message") {
            subject.execute(onSuccess: { result in
              XCTFail()
            }, onError: { error in
              requestError = error
            })
            expect(requestError?.message).toEventually(equal("message invalid"), timeout: 5.5, pollInterval: 0.5)
            expect(requestError?.status).toEventually(equal(13), timeout: 5.5, pollInterval: 0.5)
            expect(requestError?.error).toEventually(equal("title invalid"), timeout: 5.5, pollInterval: 0.5)
          }
        }
        context("empty data") {
          beforeEach {
            self.stub(everything, http(200))
          }
          it("returns a fail message") {
            subject.execute(onSuccess: { result in
              XCTFail()
            }, onError: { error in
              requestError = error
            })
            expect(requestError?.message).toEventually(equal("Try again later"), timeout: 5.5, pollInterval: 0.5)
            expect(requestError?.status).toEventually(equal(0), timeout: 5.5, pollInterval: 0.5)
            expect(requestError?.error).toEventually(equal("Missing Data"), timeout: 5.5, pollInterval: 0.5)
          }
        }
        context("no internet") {
          beforeEach {
            subject = Interactor<DummyModel>(urlConfig: urlConfig, hasConnection: false)
            self.stub(everything, http(200))
          }
          it("returns a fail message") {
            subject.execute(onSuccess: { result in
              XCTFail()
            }, onError: { error in
              requestError = error
            })
            expect(requestError?.message).toEventually(equal("Please, check network connection"), timeout: 5.5, pollInterval: 0.5)
            expect(requestError?.status).toEventually(equal(0), timeout: 5.5, pollInterval: 0.5)
            expect(requestError?.error).toEventually(equal("No Connection"), timeout: 5.5, pollInterval: 0.5)
          }
        }
      }
    }
  }
}
