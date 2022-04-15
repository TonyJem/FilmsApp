import UIKit

class FilmPicsViewController: UIViewController {
    
    @IBOutlet weak var picsNumberLabel: UILabel!
    @IBOutlet weak var filmPicsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
    }
    
    // MARK: - Private methods
    private func setupDelegates() {
        filmPicsCollectionView.dataSource = self
        filmPicsCollectionView.delegate = self
    }
    
}

// MARK: - UICollectionViewDataSource
extension FilmPicsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filmPicsCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmPicCell", for: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FilmPicsViewController: UICollectionViewDelegate {
}
