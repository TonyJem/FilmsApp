import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var sortingButton: UIBarButtonItem!
    
    let model = Core.model
    let realm = try? Realm()
    let service = URLService()
    
    private var searchController = UISearchController()
    
    // MARK: - LifeCycle
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
        
        setupSortingButton()
        
        DispatchQueue.main.async {
            self.service.dataRequest(request: .popular)
        }
        
        mainCollectionView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func sortingButtonPressed(_ sender: UIBarButtonItem) {
        model.isSortedAscending = !model.isSortedAscending
        setupSortingButton()
        
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
    
    // MARK: - Private Methods
    private func setupSortingButton() {
        let arrowUpImage = UIImage(systemName: "arrow.up")
        let arrowDownImage = UIImage(systemName: "arrow.down")
        sortingButton.image = model.isSortedAscending ? arrowUpImage : arrowDownImage
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.filmObjectsSorted?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "CustomFilmCell", for: indexPath) as? FilmCollectionViewCell,
        let item = model.filmObjectsSorted?[indexPath.row] else {
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
        destinationVC.cameFromFav = false
        destinationVC.receivedIndex = indexPath.row
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

// MARK: - SearchBar Methods
extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count != 0 {
            model.search(searchTextValue: searchText)
        }
        
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchController.searchBar.text = ""
        model.searchTextValue = ""
        
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
}
