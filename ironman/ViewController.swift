import UIKit

class ViewController: UIViewController {

  private let margin: CGFloat = 16

  @IBOutlet weak var collectionView: UICollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.offwhite
    collectionView.contentInset = UIEdgeInsets(top: margin, left: margin, bottom: 0, right: margin)
  }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardGameCollectionViewCell

//    cell.contentView.layer.cornerRadius = 8.0
//    cell.contentView.layer.borderWidth = 1.0
//    cell.contentView.layer.borderColor = UIColor.clear.cgColor
//    cell.contentView.layer.masksToBounds = true
//    cell.layer.shadowColor = UIColor.lightGray.cgColor
//    cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//    cell.layer.shadowRadius = 2.0
//    cell.layer.shadowOpacity = 1.0
//    cell.layer.masksToBounds = false
//    cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath

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
}
