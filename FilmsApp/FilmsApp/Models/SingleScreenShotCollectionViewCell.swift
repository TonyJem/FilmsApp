import UIKit

class SingleScreenShotCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var screenshotImageView: UIImageView!
    
    var selectedId: Int? {
        didSet {
            guard let selectedId = self.selectedId else { return }
            let imagePath = Core.tempStorage.screenshots[selectedId]
            guard let url = URL(string: Constants.urlBase + imagePath) else { return }
            Core.urlService.getSetPosters(withURL: url, imageView: screenshotImageView)
        }
    }
}
