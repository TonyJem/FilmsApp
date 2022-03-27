import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var data: FilmObject? {
        
        didSet {
            
            guard let unwrData = data else { return }
            
            posterImageView.image = UIImage(named: unwrData.filmPic)
            filmTitleLabel.text = unwrData.filmTitle
            yearLabel.text = String(unwrData.releaseYear)
            ratingLabel.text = String(unwrData.filmRating)
        }
    }
}
