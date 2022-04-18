import UIKit

class FavoriteFilmsViewController: UIViewController {
    
    @IBOutlet weak var favoriteFilmsCollectionView: UICollectionView!
    @IBOutlet weak var updateButton: UIBarButtonItem!
    
    let model = Core.model
    private var filmsSelectedToRemoveFromLikedFilms: [Int] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBackButton()
        setupDelegates()
        registerCells()
        reloadCollectionViewData()
    }
    
    // MARK: - Actions
    @IBAction func updateButtonPressed(_ sender: UIBarButtonItem) {
        guard !filmsSelectedToRemoveFromLikedFilms.isEmpty else { return }
        
        removeSelectedFilmsFromLikedFilms()
        reloadCollectionViewData()
    }
    
    @objc private func leftBarButtonAction() {
        guard !filmsSelectedToRemoveFromLikedFilms.isEmpty else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        showAlert(title: "Warning", message: "Selected items will be removed from liked films") {
            self.dismiss(animated: true)
            self.removeSelectedFilmsFromLikedFilms()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Private Methods
    private func removeSelectedFilmsFromLikedFilms() {
        for id in filmsSelectedToRemoveFromLikedFilms {
            model.removeFromLikedBy(id: id)
        }
        filmsSelectedToRemoveFromLikedFilms = []
    }
    
    private func setupNavigationBackButton() {
        navigationItem.hidesBackButton = true
        let navBackButton = UIBarButtonItem(title: "FilmsApp",
                                            style: UIBarButtonItem.Style.plain,
                                            target: self,
                                            action: #selector(leftBarButtonAction))
        navigationItem.leftBarButtonItem = navBackButton
    }
    
    private func showAlert(title: String, message: String?, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { _ in completionHandler() }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func setupDelegates() {
        favoriteFilmsCollectionView.delegate = self
        favoriteFilmsCollectionView.dataSource = self
    }
    
    private func registerCells() {
        let xibFavCell = UINib(nibName: "FavoriteFilmViewCell", bundle: nil)
        favoriteFilmsCollectionView.register(xibFavCell, forCellWithReuseIdentifier: "FavoriteFilmCell")
    }
    
    private func reloadCollectionViewData() {
        DispatchQueue.main.async {
            self.favoriteFilmsCollectionView.reloadData()
        }
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
        
        cell.likedFilmViewCellDelegate = self
        
        var film = Film(from: likedFilm)
        film.isSelectedToRemoveFromLikedFilms = filmsSelectedToRemoveFromLikedFilms.contains(film.id)
        cell.likedFilm = film
        
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

// MARK: - LikedFilmViewCellDelegate
extension FavoriteFilmsViewController: LikedFilmViewCellDelegate {
    func deleteButtonDidTapOnFilmWith(id: Int) {
        
        if let index = filmsSelectedToRemoveFromLikedFilms.firstIndex(of: id) {
            filmsSelectedToRemoveFromLikedFilms.remove(at: index)
        } else {
            filmsSelectedToRemoveFromLikedFilms.append(id)
        }
        
        print("🟢 filmsSelectedToRemoveFromLikedFilms : \(filmsSelectedToRemoveFromLikedFilms)")
        reloadCollectionViewData()
        
    }
}
