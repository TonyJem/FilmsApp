import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var data: FilmObject? {
        
        didSet {
            
            guard data != nil else {
                return
            }
            
            posterImageView.image = UIImage(named: data?.filmPic ?? "image01")
            filmTitleLabel.text = data?.filmTitle
            yearLabel.text = String(data?.releaseYear ?? 0)
            ratingLabel.text = String(data?.filmRating ?? 0.0)
        }
    }
}
