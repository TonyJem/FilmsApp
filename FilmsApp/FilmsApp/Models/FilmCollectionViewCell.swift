import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var data: FilmObject? {
        
        didSet {
            guard let data = self.data,
                  let url = URL(string: Constants.urlBase + data.filmPic) else {
                return
            }
            
            Core.urlService.getSetPosters(withURL: url, imageView: posterImageView)
            
            filmTitleLabel.text = data.filmTitle
            yearLabel.text = String(data.releaseYear)
            ratingLabel.text = String(data.filmRating)
        }
    }
}
