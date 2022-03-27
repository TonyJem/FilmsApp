import UIKit

class FavoriteFilmViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favoritePosterImageView: UIImageView!
    @IBOutlet weak var favoriteFilmTitleLabel: UILabel!
    @IBOutlet weak var favoriteYearLabel: UILabel!
    @IBOutlet weak var favoriteRatingLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    let model = Model()
    
    var cellIndex: Int?
    
    var data: FilmObject? {
        
        didSet {
            guard let likedData = data else { return }
            
            favoritePosterImageView.image = UIImage(named: likedData.filmPic)
            favoriteFilmTitleLabel.text = likedData.filmTitle
            favoriteYearLabel.text = String(likedData.releaseYear)
            favoriteRatingLabel.text = String(likedData.filmRating)
        }
    }
    
    @IBAction func deleteFromFavPressed(_ sender: UIButton) {
        guard let likedData = data else { return }
        
        model.updateLike(at: likedData.id)
        
        if alpha == 0.55 {
            alpha = 1
        } else if alpha == 1 {
            alpha = 0.55
        }
    }
}
