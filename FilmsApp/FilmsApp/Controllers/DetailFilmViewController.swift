import UIKit

class DetailFilmViewController: UIViewController {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var filmTitleLabel: UILabel!
    @IBOutlet private weak var releaseYearLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var galleryCollection: UICollectionView!
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    var receivedIndex: Int = Int()
    var transition: RoundingTransition = RoundingTransition()
    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posterImageView.image = UIImage(named: model.testArray[receivedIndex].testPic ?? "image01")
        filmTitleLabel.text = model.testArray[receivedIndex].testTitle
        releaseYearLabel.text = String(model.testArray[receivedIndex].testYear ?? 0)
        ratingLabel.text = String(model.testArray[receivedIndex].testRating ?? 0.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? PosterFullViewController else { return }
        destinationVC.detailIndexPath = receivedIndex
        
        destinationVC.transitioningDelegate = self
        destinationVC.modalPresentationStyle = .custom
    }
    
    @IBAction func tapGestureAction(_ sender: Any) {
    }
}

extension DetailFilmViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionProfile = .show
        transition.start = posterImageView.center
        transition.roundColor = UIColor.lightGray
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionProfile = .cancel
        transition.start = posterImageView.center
        transition.roundColor = UIColor.lightGray
        
        return transition
    }
}
