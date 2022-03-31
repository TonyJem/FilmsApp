import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var sortingButton: UIBarButtonItem!
    
    @IBAction func sortingButtonPressed(_ sender: UIBarButtonItem) {
        let arrowUp = UIImage(systemName: "arrow.up")
        let arrowDown = UIImage(systemName: "arrow.down")
        
        model.sortAscending = !model.sortAscending
        sortingButton.image = model.sortAscending ? arrowUp : arrowDown
        model.ratingSort()
        
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
    
    let model = Model()
    let realm = try? Realm()
    let service = URLService()
    
    var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Find Your Film"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        let xibCell = UINib(nibName: "FilmCollectionViewCell", bundle: nil)
        mainCollectionView.register(xibCell, forCellWithReuseIdentifier: "CustomFilmCell")
        
        DispatchQueue.main.async {
            self.service.dataRequest(request: .popular)
        }
        
        mainCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.arrayHelper?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "CustomFilmCell", for: indexPath) as? FilmCollectionViewCell,
              let item = model.arrayHelper?[indexPath.row] else {
            return UICollectionViewCell()
        }
        
        cell.data = item
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailFilmViewControllerS") as? DetailFilmViewController else {
            return
        }
        destinationVC.receivedIndex = model.arrayHelper?[indexPath.row].id ?? 0
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

// MARK: - SearchBar Methods

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        model.arrayHelper = model.filmObjects
        model.search(searchTextValue: searchText)
        
        if searchBar.text?.count == 0 {
            model.arrayHelper = model.filmObjects
            model.ratingSort()
        }
        
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        model.arrayHelper = model.filmObjects
        
        if searchBar.text?.count == 0 {
            model.arrayHelper = model.filmObjects
            model.ratingSort()
        }
        
        model.ratingSort()
        
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
}
