import UIKit
import RealmSwift

final class PosterFullViewController: UIViewController {
    
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var fullPosterImageView: UIImageView!
    
    // MARK: - Properties
    
    let model = Model()
    var detailIndexPath: Int = Int()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.width / 2
    }
    
    // MARK: - Actions
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        closeButton.clipsToBounds = true
        fullPosterImageView.image = UIImage(named: model.filmObjects?[detailIndexPath].filmPic ?? "image01")
    }
}
