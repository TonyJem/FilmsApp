import UIKit

class SingleScreenShotViewController: UIViewController {
    
    @IBOutlet private weak var fullPicGalleryCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
    }
    
    // MARK: - Private methods
    private func setupDelegates() {
        fullPicGalleryCollection.dataSource = self
        fullPicGalleryCollection.delegate = self
    }
}

// MARK: - UICollectionViewDataSource
extension SingleScreenShotViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = fullPicGalleryCollection.dequeueReusableCell(withReuseIdentifier: "FullPicCell", for: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SingleScreenShotViewController: UICollectionViewDelegate {
}
