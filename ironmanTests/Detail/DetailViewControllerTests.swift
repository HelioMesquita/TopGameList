import Quick
import Nimble

@testable import ironman

class DetailViewControllerTests: QuickSpec {

  override func spec() {
    super.spec()

    var subject: DetailViewController!
    let storyboard = UIStoryboard(name:"Main", bundle: nil)

    func insertWindow() {
      let window = UIWindow(frame: UIScreen.main.bounds)
      window.makeKeyAndVisible()
      window.rootViewController = subject
    }

    describe("#ViewDidLoad") {
      context("calls to present with nil game") {
        context("shows game details and hide noDetailsLabel") {
          beforeEach {
            subject = storyboard.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
            let game = Game(viewers: 0, channels: 0, imageUrl: URL(string: "www.google.com.br")!, name: "Iron Man")
            subject.game = game
            insertWindow()
            let _ = subject.view
          }

          it("return true") {
            expect(subject.noDetailsLabel.isHidden).to(beTrue())
          }
        }
      }
      context("calls to present with nil game") {
        context("hide game details and show noDetailsLabel") {
          beforeEach {
            subject = storyboard.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
            insertWindow()
            let _ = subject.view
          }

          it("return false") {
            expect(subject.noDetailsLabel.isHidden).to(beFalse())
          }
        }
      }
    }
  }
}
