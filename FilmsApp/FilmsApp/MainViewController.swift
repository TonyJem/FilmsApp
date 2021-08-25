import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var filmsSearchBar: UISearchBar!
    @IBOutlet private weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmsSearchBar.delegate = self
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        mainCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
    }
    
}

// MARK: UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    
}

// MARK: UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? UICollectionViewCell
//        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .blue
        return UICollectionViewCell()
    }
}
