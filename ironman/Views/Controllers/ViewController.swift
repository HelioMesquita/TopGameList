import UIKit

class ViewController: UIViewController {

  private let margin: CGFloat = 16
  var gameList: GameList?

  @IBOutlet weak var collectionView: UICollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.offwhite
    collectionView.contentInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)

    Interactor<GameList>(urlConfig: URLConfig()).execute(onSuccess: { (gameList) in
      self.gameList = gameList
      self.collectionView.reloadData()
    }, onError: {

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

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

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

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    let width = (collectionView.frame.width - 3*margin) / 2
    let height = width*1.2

    return CGSize(width: width, height: height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return margin
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return margin
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    performSegue(withIdentifier: "showDetail", sender: indexPath.row)
  }
}
