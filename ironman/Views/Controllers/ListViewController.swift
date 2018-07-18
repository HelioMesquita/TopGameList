import UIKit

class ListViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  private let margin: CGFloat = 16
  var gameList: GameList?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.offwhite
    setRefresher()
  }

  func setRefresher() {
    let refreshControl = UIRefreshControl()
    refreshControl.tintColor = UIColor.philippineYellow
    refreshControl.addTarget(self, action: #selector(load), for: .valueChanged)

    collectionView.refreshControl = refreshControl
    collectionView.alwaysBounceVertical = true
  }

  @objc func load() {
    Interactor<GameList>(urlConfig: URLConfig()).execute(onSuccess: { (gameList) in
      self.collectionView.refreshControl?.endRefreshing()
      self.gameList = gameList
      self.collectionView.reloadData()
    }, onError: {
      self.collectionView.refreshControl?.endRefreshing()
    })
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let row = sender as! Int
    let nav = segue.destination as! NavigationController
    let viewController = nav.visibleViewController as! DetailViewController
    let top = gameList?.top[row]
    viewController.top = top
    viewController.navigationItem.title = top?.game.name
  }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let total = gameList?.top.count else {
      return 0
    }
    return total
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardGameCollectionViewCell
    cell.setCell(top: gameList?.top[indexPath.row])
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    performSegue(withIdentifier: "showDetail", sender: indexPath.row)
  }

  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
  }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    let width = (collectionView.bounds.width - margin) / 2
    let height = width*1.2

    return CGSize(width: width, height: height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return margin
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return margin
  }
}
