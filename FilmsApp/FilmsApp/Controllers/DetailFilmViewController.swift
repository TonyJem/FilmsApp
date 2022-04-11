import UIKit
import RealmSwift

class DetailFilmViewController: UIViewController {
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
    var model = Core.model
    var service = URLService()
    var address = "https://image.tmdb.org/t/p/w500"
    
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
            if self.cameFromFav == false {
                guard let unwrFilmPic = self.model.films?[self.receivedIndex].filmPic,
                      let posterURL = URL(string: self.address + unwrFilmPic) else {
                    return
                }
                
                self.service.getSetPosters(withURL: posterURL, imageView: self.posterImageView)
                
                self.filmTitleLabel.text = self.model.films?[self.receivedIndex].filmTitle
                self.releaseYearLabel.text = String(self.model.films?[self.receivedIndex].releaseYear ?? 0000)
                self.ratingLabel.text = String(self.model.films?[self.receivedIndex].filmRating ?? 0)
                
                self.descriptionTextView.text = self.model.films?[self.receivedIndex].about
                
                self.likeButton.alpha = 0.45
                self.likeButton.tintColor = .gray
                
            } else if self.cameFromFav == true {
                guard let unwrFilmPic = self.model.likedFilmObjects?[self.receivedIndex].filmPic,
                      let posterURL = URL(string: self.address + unwrFilmPic) else {
                    return
                }
                
                self.service.getSetPosters(withURL: posterURL, imageView: self.posterImageView)
                
                self.filmTitleLabel.text = self.model.likedFilmObjects?[self.receivedIndex].filmTitle
                self.releaseYearLabel.text = String(self.model.likedFilmObjects?[self.receivedIndex].releaseYear ?? 0000)
                self.ratingLabel.text = String(self.model.likedFilmObjects?[self.receivedIndex].filmRating ?? 0)
                
                self.descriptionTextView.text = self.model.likedFilmObjects?[self.receivedIndex].about
                
                if self.model.likedFilmObjects?[self.receivedIndex].isLikedByUser == true {
                    self.likeButton.alpha = 1
                    self.likeButton.tintColor = .black
                }
            }
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
        
        model.updateLike(at: receivedIndex)
        
        if likeButton.alpha == 1 {
            likeButton.alpha = 0.45
            print("🔴 heart_gray")
            likeButton.setBackgroundImage(UIImage(named: "heart_red"), for: .normal)
        } else {
            likeButton.alpha = 1
            print("🟢 heart_red")
            likeButton.setBackgroundImage(UIImage(named: "heart_gray"), for: .normal)
        }
    }
    
    @IBAction func goToGAlleryButtonAction(_ sender: UIButton) {
        print("🟢🟢🟢 goToGAlleryButtonAction in DetailFilmViewController")
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
