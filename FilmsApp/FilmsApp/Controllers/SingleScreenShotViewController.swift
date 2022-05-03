import UIKit

class SingleScreenShotViewController: UIViewController {
    
    @IBOutlet private weak var fullPicGalleryCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
        registerCells()
    }
    
    // MARK: - Private methods
    private func setupDelegates() {
        fullPicGalleryCollection.dataSource = self
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
