import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var filmTitleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    
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
