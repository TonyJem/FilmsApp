import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var data: Item? {
        
        didSet {
            
            guard data != nil else {
                return
            }
            
            posterImageView.image = UIImage(named: data?.testPic ?? "image01")
            filmTitleLabel.text = data?.testTitle
            yearLabel.text = String(data?.testYear ?? 0)
            ratingLabel.text = String(data?.testRating ?? 0.0)
        }
    }
}
