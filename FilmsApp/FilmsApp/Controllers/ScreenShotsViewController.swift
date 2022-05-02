import UIKit

class ScreenShotsViewController: UIViewController {
    @IBOutlet private weak var picsNumberLabel: UILabel!
    @IBOutlet private weak var filmPicsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
        registerCells()
    }
    
    // MARK: - Private methods
    private func setupDelegates() {
        filmPicsCollectionView.dataSource = self
        filmPicsCollectionView.delegate = self
    }
    
    private func registerCells() {
        let xibFavCell = UINib(nibName: "ScreenShotCollectionViewCell", bundle: nil)
        filmPicsCollectionView.register(xibFavCell, forCellWithReuseIdentifier: "GalleryPreviewCell")
    }
}

// MARK: - UICollectionViewDataSource
extension ScreenShotsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Core.tempStorage.screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = filmPicsCollectionView.dequeueReusableCell(withReuseIdentifier: "GalleryPreviewCell", for: indexPath) as? ScreenShotCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.selectedId = indexPath.row
        
        return cell
    }
}

// MARK: - CollectionView DelegateFlowLayout
extension ScreenShotsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 128)
    }
}

// MARK: - UICollectionViewDelegate
extension ScreenShotsViewController: UICollectionViewDelegate {
}
