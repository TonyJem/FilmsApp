import UIKit

class ScreenShotsViewController: UIViewController {
    @IBOutlet private weak var picsNumberLabel: UILabel!
    @IBOutlet private weak var filmPicsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupDelegates()
        registerCells()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        picsNumberLabel.text = "\(Core.tempStorage.screenshots.count) кадров"
    }
    
    private func setupDelegates() {
        filmPicsCollectionView.dataSource = self
        filmPicsCollectionView.delegate = self
    }
    
    private func registerCells() {
        let xibFavCell = UINib(nibName: "BigScreenShotCollectionViewCell", bundle: nil)
        filmPicsCollectionView.register(xibFavCell, forCellWithReuseIdentifier: "ScreenShotGalleryCell")
    }
}

// MARK: - UICollectionViewDataSource
extension ScreenShotsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Core.tempStorage.screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = filmPicsCollectionView.dequeueReusableCell(withReuseIdentifier: "ScreenShotGalleryCell", for: indexPath) as? BigScreenShotCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.selectedId = indexPath.row
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ScreenShotsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let destinationVC = storyboard?.instantiateViewController(withIdentifier: "SingleScreenShotViewControllerID") as? SingleScreenShotViewController else {
            return
        }
        
        destinationVC.selectedItem = indexPath.row
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

// MARK: - CollectionView DelegateFlowLayout
extension ScreenShotsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = 320
        let height = width * 0.625
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
