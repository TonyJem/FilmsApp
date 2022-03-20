import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var filmsSearchBar: UISearchBar!
    @IBOutlet private weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmsSearchBar.delegate = self
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        let xibCell = UINib(nibName: "FilmCollectionViewCell", bundle: nil)
        mainCollectionView.register(xibCell, forCellWithReuseIdentifier: "FilmCell")
        mainCollectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as? FilmCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .blue
        
        let testItem = testArray[indexPath.item]
        cell.film = testItem
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    
}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    
}
