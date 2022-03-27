import UIKit
import RealmSwift

class FavoriteFilmsViewController: UIViewController {
    
    @IBOutlet weak var favoriteFilmsCollectionView: UICollectionView!
    @IBOutlet weak var updateButton: UIBarButtonItem!
    
    let model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.showLikedFilms()
        
        favoriteFilmsCollectionView.delegate = self
        favoriteFilmsCollectionView.dataSource = self
        
        let xibFavCell = UINib(nibName: "FavoriteFilmViewCell", bundle: nil)
        
        favoriteFilmsCollectionView.register(xibFavCell, forCellWithReuseIdentifier: "FavoriteFilmCell")
        
        favoriteFilmsCollectionView.reloadData()
    }
    
    @IBAction func updateButtonPressed(_ sender: UIBarButtonItem) {
        favoriteFilmsCollectionView.reloadData()
    }
}

extension FavoriteFilmsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.likedFilmObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = favoriteFilmsCollectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteFilmCell", for: indexPath) as? FavoriteFilmViewCell,
              let likedItem = model.likedFilmObjects?[indexPath.row]  else {
            return UICollectionViewCell()
        }
        
        cell.data = likedItem
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailFilmViewControllerS") as? DetailFilmViewController else {
            return
        }
        
        destinationVC.receivedIndex = model.likedFilmObjects?[indexPath.row].id ?? 0
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
