import UIKit

class SingleScreenShotViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var fullPicGalleryCollection: UICollectionView!
    
    var selectedItem: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleLabelWith(selectedItem)
        setupDelegates()
        registerCells()
        showSelectedItem()
    }
    
    // MARK: - Private methods
    private func setupTitleLabelWith(_ selectedItem: Int?) {
        guard let selectedItem = selectedItem else {
            titleLabel.text = ""
            return
        }
        
        titleLabel.text = "\(selectedItem + 1)/\(Core.tempStorage.screenshots.count)"
    }
    
    private func setupDelegates() {
        fullPicGalleryCollection.dataSource = self
        fullPicGalleryCollection.delegate = self
    }
    
    private func registerCells() {
        let xibFavCell = UINib(nibName: "SingleScreenShotCollectionViewCell", bundle: nil)
        fullPicGalleryCollection.register(xibFavCell, forCellWithReuseIdentifier: "SingleScreenShotGalleryCell")
    }
    
    private func showSelectedItem() {
        guard let selectedItem = self.selectedItem else { return }
        let indexPath = IndexPath(item: selectedItem, section: .zero)
        fullPicGalleryCollection.scrollToItem(at: indexPath, at: .right, animated: false)
        fullPicGalleryCollection.layoutSubviews()
    }
}

// MARK: - UICollectionViewDataSource
extension SingleScreenShotViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Core.tempStorage.screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = fullPicGalleryCollection.dequeueReusableCell(withReuseIdentifier: "SingleScreenShotGalleryCell", for: indexPath) as? SingleScreenShotCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.selectedId = indexPath.row
        return cell
    }
}

// MARK: - CollectionView DelegateFlowLayout
extension SingleScreenShotViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width - 10, height: frameSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}

// MARK: - CollectionView's Scroll view Delegate
extension SingleScreenShotViewController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = fullPicGalleryCollection.contentOffset
        visibleRect.size = fullPicGalleryCollection.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        guard let indexPath = fullPicGalleryCollection.indexPathForItem(at: visiblePoint) else { return }
        setupTitleLabelWith(indexPath.row)
    }
}
