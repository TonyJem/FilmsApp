import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var film: TestModel? {
        didSet {
            guard let unwrappedFilm = film else { return }
            posterImageView.image = UIImage(named: unwrappedFilm.testPic ?? "untitledPicture")
            filmTitleLabel.text = unwrappedFilm.testTitle
            yearLabel.text = unwrappedFilm.testYear
            ratingLabel.text = unwrappedFilm.testRating
        }
    }
}
