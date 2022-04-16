import UIKit

class DetailFilmViewController: UIViewController {
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var galleryCollection: UICollectionView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    let model = Core.model
    
    var film: Film?
    
    private var posterImage: UIImage? {
        posterImageView.image
    }
    
    private var transition: RoundingTransition = RoundingTransition()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likeButton.clipsToBounds = true
        likeButton.contentMode = .scaleAspectFill
        
        galleryCollection.dataSource = self
        galleryCollection.delegate = self
        
        galleryCollection.layer.borderWidth = 2.4
        galleryCollection.layer.borderColor = UIColor.darkGray.cgColor
        
        DispatchQueue.main.async {
            self.setupFilmDetails()
        }
    }
    
    // MARK: - Override methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? PosterFullViewController else { return }
        
        destinationVC.transitioningDelegate = self
        destinationVC.modalPresentationStyle = .custom
        destinationVC.posterImage = posterImage
    }
    
    // MARK: - Actions
    @IBAction func likeButtonDidTap(_ sender: UIButton) {
        guard let id = self.film?.id else { return }
        model.updateLikeForFilmWith(id: id)
        setLikeButtonImageForFilmWith(id: id)
    }
    
    @IBAction func goToGAlleryButtonAction(_ sender: UIButton) {
        print("🟢🟢🟢 goToGAlleryButtonAction in DetailFilmViewController")
    }
    
    // MARK: - Private methods
    private func setLikeButtonImageForFilmWith(id: Int) {
        let isFilmLiked = model.isInLikedFilmsBy(id: id)
        let imageName = isFilmLiked ? "heart_red" : "heart_gray"
        likeButton.setBackgroundImage(UIImage(named: imageName), for: .normal)
    }
    
    private func setupFilmDetails() {
        guard let film = self.film else { return }
        let pictureStringURL = film.pictureStringURL
        
        guard let posterURL = URL(string: Constants.urlBase + pictureStringURL) else { return }
        
        Core.urlService.getSetPosters(withURL: posterURL, imageView: posterImageView)
        
        filmTitleLabel.text = film.filmTitle
        releaseYearLabel.text = String(film.releaseYear)
        ratingLabel.text = String(film.filmRating)
        descriptionTextView.text = film.about
        setLikeButtonImageForFilmWith(id: film.id)
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

// MARK: - UIViewController TransitioningDelegate
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
