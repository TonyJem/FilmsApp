import UIKit

class FavoriteFilmsViewController: UIViewController {
    
    @IBOutlet weak var favoriteFilmsCollectionView: UICollectionView!
    @IBOutlet weak var updateButton: UIBarButtonItem!
    
    let model = Core.model
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
        
        let xibFavCell = UINib(nibName: "FavoriteFilmViewCell", bundle: nil)
        favoriteFilmsCollectionView.register(xibFavCell, forCellWithReuseIdentifier: "FavoriteFilmCell")
        
        reloadCollectionViewData()
    }
    
    // MARK: - Actions
    @IBAction func updateButtonPressed(_ sender: UIBarButtonItem) {
        reloadCollectionViewData()
    }
    
    // MARK: - Private Methods
    private func reloadCollectionViewData() {
        DispatchQueue.main.async {
            self.favoriteFilmsCollectionView.reloadData()
        }
    }
    
    private func setupDelegates() {
        favoriteFilmsCollectionView.delegate = self
        favoriteFilmsCollectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDataSource
extension FavoriteFilmsViewController:  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.likedFilms?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = favoriteFilmsCollectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteFilmCell", for: indexPath) as? FavoriteFilmViewCell,
              let likedFilm = model.likedFilms?[indexPath.item] else {
            return UICollectionViewCell()
        }
        
        cell.data = likedFilm
        cell.cellIndex = indexPath.row
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FavoriteFilmsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailFilmViewControllerS") as? DetailFilmViewController,
              let selectedFilm = model.likedFilms?[indexPath.row] else {
            return
        }
        
        let film = Film(from: selectedFilm)
        destinationVC.film = film
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
