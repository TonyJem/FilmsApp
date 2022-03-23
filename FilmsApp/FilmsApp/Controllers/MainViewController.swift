import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var sortingButton: UIBarButtonItem!
    
    @IBAction func sortingButtonPressed(_ sender: UIBarButtonItem) {
        let arrowUp = UIImage(systemName: "arrow.up")
        let arrowDown = UIImage(systemName: "arrow.down")
        
        model.sortAscending = !model.sortAscending
        sortingButton.image = model.sortAscending ? arrowUp : arrowDown
        model.ratingSort()
        mainCollectionView.reloadData()
    }
    
    let model = Model()
    
    var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.newTestArray = model.testArray
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Find Your Film"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        let xibCell = UINib(nibName: "FilmCollectionViewCell", bundle: nil)
        mainCollectionView.register(xibCell, forCellWithReuseIdentifier: "FilmCell")
        model.ratingSort()
        mainCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.newTestArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as? FilmCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.data = self.model.newTestArray[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailFilmViewControllerID") as? DetailFilmViewController else {
            return
        }
        destinationVC.receivedIndex = model.newTestArray[indexPath.row].id ?? 0
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
}

// MARK: - SearchBar Methods

extension MainViewController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.search(searchTextValue: searchText)
        mainCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        model.newTestArray = model.testArray
        mainCollectionView.reloadData()
    }
}
