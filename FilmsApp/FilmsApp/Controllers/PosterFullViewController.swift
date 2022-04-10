import UIKit
import RealmSwift

final class PosterFullViewController: UIViewController {
    
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var fullPosterImageView: UIImageView!
    
    // MARK: - Properties
    
    let model = Core.model
    let service = URLService()
    let address = "https://image.tmdb.org/t/p/w500"
    
    var detailIndexPath: Int = Int()
    var isFavorited: Bool = Bool()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isFavorited == false {
            guard let unwrFilmPic = self.model.films?[self.detailIndexPath].filmPic,
                  let posterURL = URL(string: self.address + unwrFilmPic) else {
                return
            }
            service.getSetPosters(withURL: posterURL, imageView: fullPosterImageView)
            
        } else if isFavorited == true {
            guard let unwrFilmPic = self.model.likedFilmObjects?[self.detailIndexPath].filmPic,
                  let posterURL = URL(string: self.address + unwrFilmPic) else {
                return
            }
            
            service.getSetPosters(withURL: posterURL, imageView: fullPosterImageView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.width / 2
    }
    
    // MARK: - Actions
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
