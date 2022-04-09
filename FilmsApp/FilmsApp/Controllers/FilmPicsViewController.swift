import UIKit
import RealmSwift

class FilmPicsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var picsNumberLabel: UILabel!
    @IBOutlet weak var filmPicsCollectionView: UICollectionView!
    
    let model = Core.model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmPicsCollectionView.dataSource = self
        filmPicsCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filmPicsCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmPicCell", for: indexPath)
        return cell
    }
}
