import UIKit

class FullPicViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var fullPicGalleryCollection: UICollectionView!
    
    let model = Core.model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullPicGalleryCollection.dataSource = self
        fullPicGalleryCollection.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = fullPicGalleryCollection.dequeueReusableCell(withReuseIdentifier: "FullPicCell", for: indexPath)
        return cell
    }
}
