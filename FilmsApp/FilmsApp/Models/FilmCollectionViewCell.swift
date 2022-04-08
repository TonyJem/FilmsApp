import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    let urlService = URLService()
    let urlBase = "https://image.tmdb.org/t/p/w500"
    
    var data: FilmObject? {
        
        didSet {
            guard let unwrData = data,
                  let url = URL(string: urlBase + unwrData.filmPic) else {
                return
            }
            
            urlService.getSetPosters(withURL: url, imageView: posterImageView)
            
            filmTitleLabel.text = unwrData.filmTitle
            yearLabel.text = String(unwrData.releaseYear)
            ratingLabel.text = String(unwrData.filmRating)
        }
    }
}
