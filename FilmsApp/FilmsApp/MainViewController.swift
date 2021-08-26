import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var filmsSearchBar: UISearchBar!
    @IBOutlet private weak var mainCollectionView: UICollectionView!
    
    var testArray: [TestModel] = [
        TestModel(testPic: "image01", testTitle: "Film 01", testYear: "2001", testRating: "4.1"),
        TestModel(testPic: "image02", testTitle: "Film 02", testYear: "2002", testRating: "4.2"),
        TestModel(testPic: "image03", testTitle: "Film 03", testYear: "2003", testRating: "4.3"),
        TestModel(testPic: "image04", testTitle: "Film 04", testYear: "2004", testRating: "4.4"),
        TestModel(testPic: "image05", testTitle: "Film 05", testYear: "2005", testRating: "4.5"),
        TestModel(testPic: "image06", testTitle: "Film 06", testYear: "2006", testRating: "4.6"),
        TestModel(testPic: "image07", testTitle: "Film 07", testYear: "2007", testRating: "4.7"),
        TestModel(testPic: "image08", testTitle: "Film 08", testYear: "2008", testRating: "4.8"),
        TestModel(testPic: "image09", testTitle: "Film 09", testYear: "2009", testRating: "4.9"),
        TestModel(testPic: "image10", testTitle: "Film 10", testYear: "2010", testRating: "5.0"),
        TestModel(testPic: "image11", testTitle: "Film 11", testYear: "2011", testRating: "5.1"),
        TestModel(testPic: "image12", testTitle: "Film 12", testYear: "2012", testRating: "5.2"),
        TestModel(testPic: "image13", testTitle: "Film 13", testYear: "2013", testRating: "5.3"),
        TestModel(testPic: "image14", testTitle: "Film 14", testYear: "2014", testRating: "5.4"),
        TestModel(testPic: "image15", testTitle: "Film 15", testYear: "2015", testRating: "5.5")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmsSearchBar.delegate = self
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        mainCollectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: "FilmCell")
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
        return testArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as? FilmCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .blue
        return cell
    }
}
