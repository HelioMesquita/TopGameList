protocol DetailPresentable: class {
  func showDetail(game: Game)
}

class DetailPresenter {

  var delegate: DetailPresentable
  var game: Game?

  init(game: Game?, delegate: DetailPresentable) {
    self.game = game
    self.delegate = delegate
  }

  func present() {
    guard let game = game else { return }
    delegate.showDetail(game: game)
  }
}
