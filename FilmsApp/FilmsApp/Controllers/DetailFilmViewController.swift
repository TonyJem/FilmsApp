import UIKit

class DetailFilmViewController: UIViewController {
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var galleryCollection: UICollectionView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var isLiked: Bool = false
    var cameFromFav: Bool = Bool()
    var receivedIndex: Int = Int()
    var transition: RoundingTransition = RoundingTransition()
    var model = Core.model
    var service = Core.urlService
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likeButton.clipsToBounds = true
        likeButton.contentMode = .scaleAspectFill
        
        setLikeButtonImage()
        
        galleryCollection.dataSource = self
        galleryCollection.delegate = self
        
        galleryCollection.layer.borderWidth = 2.4
        galleryCollection.layer.borderColor = UIColor.darkGray.cgColor
        
        DispatchQueue.main.async {
            self.cameFromFav ? self.showFavouriteFilms() : self.showNormalFilms()
        }
    }
    
    // MARK: - Override methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? PosterFullViewController else { return }
        destinationVC.detailIndexPath = receivedIndex
        destinationVC.isFavorited = cameFromFav
        
        destinationVC.transitioningDelegate = self
        destinationVC.modalPresentationStyle = .custom
    }
    
    // MARK: - Actions
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        
        //        model.updateLike(at: receivedIndex)
        
        setLikeButtonImage()
    }
    
    @IBAction func goToGAlleryButtonAction(_ sender: UIButton) {
        print("🟢🟢🟢 goToGAlleryButtonAction in DetailFilmViewController")
    }
    
    // MARK: - Private methods
    private func setLikeButtonImage() {
        if isLiked {
            likeButton.setBackgroundImage(UIImage(named: "heart_red"), for: .normal)
        } else {
            likeButton.setBackgroundImage(UIImage(named: "heart_gray"), for: .normal)
        }
        isLiked = !isLiked
    }
    
    private func showNormalFilms() {
        guard let unwrFilmPic = model.films?[receivedIndex].filmPic,
              let posterURL = URL(string: Constants.urlBase + unwrFilmPic) else {
            return
        }
        
        service.getSetPosters(withURL: posterURL, imageView: posterImageView)
        
        filmTitleLabel.text = model.films?[receivedIndex].filmTitle
        releaseYearLabel.text = String(model.films?[receivedIndex].releaseYear ?? 0000)
        ratingLabel.text = String(model.films?[receivedIndex].filmRating ?? 0)
        
        descriptionTextView.text = model.films?[receivedIndex].about
    }
    
    private func showFavouriteFilms() {
        guard let unwrFilmPic = model.likedFilmObjects?[receivedIndex].filmPic,
              let posterURL = URL(string: Constants.urlBase + unwrFilmPic) else {
            return
        }
        
        service.getSetPosters(withURL: posterURL, imageView: posterImageView)
        
        filmTitleLabel.text = model.likedFilmObjects?[receivedIndex].filmTitle
        releaseYearLabel.text = String(model.likedFilmObjects?[receivedIndex].releaseYear ?? 0000)
        ratingLabel.text = String(model.likedFilmObjects?[receivedIndex].filmRating ?? 0)
        
        descriptionTextView.text = model.likedFilmObjects?[receivedIndex].about
        
        if model.likedFilmObjects?[receivedIndex].isLikedByUser == true {
        }
    }
    
}

// MARK: - UICollectionView DataSource
extension DetailFilmViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = galleryCollection.dequeueReusableCell(withReuseIdentifier: "GalleryPreviewCell", for: indexPath)
        return cell
    }
    
}

// MARK: - UICollectionView Delegate
extension DetailFilmViewController: UICollectionViewDelegate {
    
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
