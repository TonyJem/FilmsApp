import UIKit

class SingleScreenShotCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var screenshotImageView: UIImageView!
    
    var selectedId: Int? {
        didSet {
            guard let selectedId = self.selectedId else { return }
            let imagePath = Core.tempStorage.screenshots[selectedId]
            guard let url = URL(string: Constants.urlBase + imagePath) else { return }
            Core.urlService.getSetPosters(withURL: url, imageView: screenshotImageView)
            
            screenshotImageView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
            screenshotImageView.layer.borderWidth = 2
        }
    }
}
