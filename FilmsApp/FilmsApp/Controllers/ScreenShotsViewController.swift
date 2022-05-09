import UIKit

class ScreenShotsViewController: UIViewController {
    
    enum VCIdentifiers: String {
        case SingleBackdropVC_ID
    }
    
    @IBOutlet private weak var picsNumberLabel: UILabel!
    @IBOutlet private weak var filmPicsCollectionView: UICollectionView!
    
    var film: Film?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupDelegates()
        registerCells()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        guard let film = film else { return }
        
        picsNumberLabel.text = "\(film.screenshots.count) backdrops"
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
        guard let film = film else { return .zero }
        
        return film.screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = filmPicsCollectionView.dequeueReusableCell(withReuseIdentifier: "ScreenShotGalleryCell", for: indexPath) as? BigScreenShotCollectionViewCell,
        let film = film else {
            return UICollectionViewCell()
        }
        cell.imagePath = film.screenshots[indexPath.row]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ScreenShotsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let destinationVC = storyboard?.instantiateViewController(withIdentifier: VCIdentifiers.SingleBackdropVC_ID.rawValue) as? SingleBackdropVC else {
            return
        }
        
        destinationVC.selectedItem = indexPath.row
        destinationVC.film = film
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
