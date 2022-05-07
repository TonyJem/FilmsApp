import UIKit

class SingleScreenShotCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var screenshotImageView: UIImageView!
    
    var imagePath: String? {
        didSet {
            guard let imagePath = self.imagePath else { return }
            guard let url = URL(string: Constants.urlBase + imagePath) else { return }
            Core.urlService.getSetPosters(withURL: url, imageView: screenshotImageView)
        }
    }
}
