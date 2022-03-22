import UIKit

class FavoriteFilmViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favoritePosterImageView: UIImageView!
    @IBOutlet weak var favoriteFilmTitleLabel: UILabel!
    @IBOutlet weak var favoriteYearLabel: UILabel!
    @IBOutlet weak var favoriteRatingLabel: UILabel!
    
    var data: Item? {
        
        didSet {
            
            guard data != nil else {
                return
            }
            
            favoritePosterImageView.image = UIImage(named: data?.testPic ?? "image01")
            favoriteFilmTitleLabel.text = data?.testTitle
            favoriteYearLabel.text = String(data?.testYear ?? 0)
            favoriteRatingLabel.text = String(data?.testRating ?? 0.0)
        }
    }
}
