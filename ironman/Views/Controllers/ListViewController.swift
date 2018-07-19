import UIKit

class ListViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  var gameList = GameList()
  var presenter: ListPresenter?
  let urlQueryParams = URLQueryItem(name: "client_id", value: Bundle.main.getID())

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.offwhite
    let urlConfig = URLConfig(url: Bundle.main.getEntrypoint(), queryParams: [urlQueryParams])
    let interactor = Interactor<GameList>(urlConfig: urlConfig)
    let dataStore = GameDBDataStoreManager()
    presenter = ListPresenter(interactor: interactor, delegate: self, dataStore: dataStore)
    presenter?.performLoadData()
    presenter?.performRequest()
  }

  @objc func reload() {
    presenter?.performRequest()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let row = sender as! Int
    let nav = segue.destination as! NavigationController
    let viewController = nav.visibleViewController as! DetailViewController
    let game = gameList.list[row]
    viewController.game = game
    viewController.navigationItem.title = game.name
  }
}

extension ListViewController: ListPresentable {

  func setRefresher() {
    let refreshControl = UIRefreshControl()
    refreshControl.tintColor = UIColor.philippineYellow
    refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)

    collectionView.refreshControl = refreshControl
    collectionView.alwaysBounceVertical = true
  }

  func startLoading() {
    collectionView.refreshControl?.beginRefreshing()
  }

  func endLoading() {
    collectionView.refreshControl?.endRefreshing()
  }

  func onLoad(list: GameList) {
    self.gameList = list
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }

  func onPaginate(list: GameList) {
    self.gameList = gameList.update(newlist: list)
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }

  func prepareToLoadNextPage(url: URL) {
    let urlConfig = URLConfig(url: url, queryParams: [urlQueryParams])
    let interactor = Interactor<GameList>(urlConfig: urlConfig)
    presenter?.presentNextPage(nextInteractor: interactor)
  }

  func onError(error: RequestError) {
    let alertController = UIAlertController(title: error.error, message: error.message, preferredStyle: .alert)
    present(alertController, animated: true, completion: nil)
  }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return gameList.list.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardGameCollectionViewCell
    cell.setCell(game: gameList.list[indexPath.row])
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    performSegue(withIdentifier: "showDetail", sender: indexPath.row)
  }

  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    presenter?.handleInfinitScroll(actualRow: indexPath.row, totalRows: gameList.list.count, nextLink: gameList.links?.next)
  }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    let margin: CGFloat = 16
    let width = (collectionView.bounds.width - margin) / 2
    let height = width*1.2

    return CGSize(width: width, height: height)
  }
}
