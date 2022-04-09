import UIKit

class FavoriteFilmViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favoritePosterImageView: UIImageView!
    @IBOutlet weak var favoriteFilmTitleLabel: UILabel!
    @IBOutlet weak var favoriteYearLabel: UILabel!
    @IBOutlet weak var favoriteRatingLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    let urlService = URLService()
    let urlBase = "https://image.tmdb.org/t/p/w500"
    let model = Model()
    
    var cellIndex: Int = Int()
    
    var data: LikedFilmObject? {
        
        didSet {
            guard let likedData = data,
                  let url = URL(string: urlBase + likedData.filmPic) else {
                      return
                  }
            
            urlService.getSetPosters(withURL: url, imageView: favoritePosterImageView)
            
            favoriteFilmTitleLabel.text = likedData.filmTitle
            favoriteYearLabel.text = String(likedData.releaseYear)
            favoriteRatingLabel.text = String(likedData.filmRating)
        }
    }
    
    @IBAction func deleteFromFavPressed(_ sender: UIButton) {
        
        model.updateLike(at: cellIndex)
        
        if alpha == 0.55 {
            alpha = 1
        } else if alpha == 1 {
            alpha = 0.55
        }
    }
}
