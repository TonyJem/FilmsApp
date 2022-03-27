import UIKit
import RealmSwift

class DetailFilmViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = galleryCollection.dequeueReusableCell(withReuseIdentifier: "GalleryPreviewCell", for: indexPath)
        return cell
    }
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var galleryCollection: UICollectionView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var cameFromFav: Bool = Bool()
    var receivedIndex: Int = Int()
    var transition: RoundingTransition = RoundingTransition()
    var model = Model()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryCollection.dataSource = self
        galleryCollection.delegate = self
        
        galleryCollection.layer.borderWidth = 2.4
        galleryCollection.layer.borderColor = UIColor.darkGray.cgColor
        
        if model.filmObjects?[receivedIndex].isLikedByUser == true {
            likeButton.alpha = 1
            likeButton.tintColor = .black
        } else {
            likeButton.alpha = 0.45
            likeButton.tintColor = .gray
        }
        
        posterImageView.image = UIImage(named: model.filmObjects?[receivedIndex].filmPic ?? "image01")
        filmTitleLabel.text = model.filmObjects?[receivedIndex].filmTitle
        releaseYearLabel.text = String(model.filmObjects?[receivedIndex].releaseYear ?? 0)
        ratingLabel.text = String(model.filmObjects?[receivedIndex].filmRating ?? 0.0)
    }
    
    // MARK: - Override methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? PosterFullViewController else { return }
        destinationVC.detailIndexPath = receivedIndex
        
        destinationVC.transitioningDelegate = self
        destinationVC.modalPresentationStyle = .custom
    }
    
    // MARK: - Actions
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        print("🟢 likeButtonPressed in DetailFilmViewController")
        
        model.updateLike(at: receivedIndex)
        
        if likeButton.alpha == 1 {
            likeButton.alpha = 0.45
            likeButton.tintColor = .gray
        } else {
            likeButton.alpha = 1
            likeButton.tintColor = .black
        }
    }
    
    @IBAction func tapGestureAction(_ sender: Any) {
    }
    
    @IBAction func goToGAlleryButtonAction(_ sender: UIButton) {
        print("🟢🟢🟢 goToGAlleryButtonAction in DetailFilmViewController")
    }
    
}

// MARK: - UIViewControllerTransitioningDelegate

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
