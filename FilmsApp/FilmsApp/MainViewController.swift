import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var filmsSearchBar: UISearchBar!
    @IBOutlet private weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmsSearchBar.delegate = self
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        mainCollectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: "FilmCell")
    }
    
}

// MARK: UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    
}

// MARK: UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as? FilmCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .blue
        return cell
    }
}
