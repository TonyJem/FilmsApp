import UIKit

class DetailFilmViewController: UIViewController {
    
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var filmTitleLabel: UILabel!
    @IBOutlet private weak var releaseYearLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var galleryCollection: UICollectionView!
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    let model = Core.model
    
    var film: Film?
    var shouldHideLikeButton: Bool = false
    
    private var posterImage: UIImage? {
        posterImageView.image
    }
    
    private var transition: RoundingTransition = RoundingTransition()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likeButton.clipsToBounds = true
        likeButton.contentMode = .scaleAspectFill
        likeButton.isHidden = shouldHideLikeButton
        
        galleryCollection.dataSource = self
        galleryCollection.delegate = self
        
        galleryCollection.layer.borderWidth = 2.4
        galleryCollection.layer.borderColor = UIColor.darkGray.cgColor
        
        registerCells()
        
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
    
    // MARK: - Private methods
    private func registerCells() {
        let xibFavCell = UINib(nibName: "ScreenShotCollectionViewCell", bundle: nil)
        galleryCollection.register(xibFavCell, forCellWithReuseIdentifier: "GalleryPreviewCell")
    }
    
    
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
        return Core.tempStorage.screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = galleryCollection.dequeueReusableCell(withReuseIdentifier: "GalleryPreviewCell", for: indexPath) as? ScreenShotCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.selectedId = indexPath.row
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DetailFilmViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let destinationVC = storyboard?.instantiateViewController(withIdentifier: "SingleScreenShotViewControllerID") as? SingleScreenShotViewController else {
            return
        }
        
        destinationVC.selectedItem = indexPath.row
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

// MARK: - CollectionView DelegateFlowLayout
extension DetailFilmViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 128)
    }
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
