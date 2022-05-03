import UIKit

class SingleScreenShotViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var fullPicGalleryCollection: UICollectionView!
    
    var selectedItem: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupDelegates()
        registerCells()
    }
    
    override func viewDidLayoutSubviews() {
        guard let selectedItem = self.selectedItem else { return }
        let indexPath = IndexPath(item: selectedItem, section: .zero)
        fullPicGalleryCollection.scrollToItem(at: indexPath, at: .right, animated: false)
    }
    
    // MARK: - Private methods
    private func setupUI() {
        let selectedItem = String((selectedItem ?? 0) + 1)
        titleLabel.text = "\(selectedItem)/\(Core.tempStorage.screenshots.count)"
    }
    
    private func setupDelegates() {
        fullPicGalleryCollection.dataSource = self
        fullPicGalleryCollection.delegate = self
    }
    
    private func registerCells() {
        let xibFavCell = UINib(nibName: "SingleScreenShotCollectionViewCell", bundle: nil)
        fullPicGalleryCollection.register(xibFavCell, forCellWithReuseIdentifier: "SingleScreenShotGalleryCell")
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
