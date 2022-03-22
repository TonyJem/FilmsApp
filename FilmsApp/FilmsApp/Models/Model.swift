import Foundation
import UIKit

class Item {
    var id: Int?
    var testPic: String?
    var testTitle: String?
    var testYear: String?
    var testRating: String?
    var isLiked: Bool
    
    init(id: Int? = nil, testPic: String?, testTitle: String?, testYear: String?, testRating: String?, isliked: Bool = false) {
        self.id = id
        self.testPic = testPic
        self.testTitle = testTitle
        self.testYear = testYear
        self.testRating = testRating
        self.isLiked = isliked
    }
}

class Model {
    var testArray: [Item] = [
        Item(id: 0, testPic: "image01", testTitle: "Film 01", testYear: "2001", testRating: "4.1", isliked: true),
        Item(id: 1, testPic: "image02", testTitle: "Film 02", testYear: "2002", testRating: "4.2", isliked: false),
        Item(id: 2, testPic: "image03", testTitle: "Film 03", testYear: "2003", testRating: "4.3", isliked: true),
        Item(id: 3, testPic: "image04", testTitle: "Film 04", testYear: "2004", testRating: "4.4", isliked: true),
        Item(id: 4, testPic: "image05", testTitle: "Film 05", testYear: "2005", testRating: "4.5", isliked: false),
        Item(id: 5, testPic: "image06", testTitle: "Film 06", testYear: "2006", testRating: "4.6", isliked: true),
        Item(id: 6, testPic: "image07", testTitle: "Film 07", testYear: "2007", testRating: "4.7", isliked: true),
        Item(id: 7, testPic: "image08", testTitle: "Film 08", testYear: "2008", testRating: "4.8", isliked: false),
        Item(id: 8, testPic: "image09", testTitle: "Film 09", testYear: "2009", testRating: "4.9", isliked: true),
        Item(id: 9, testPic: "image10", testTitle: "Film 10", testYear: "2010", testRating: "5.0", isliked: false),
        Item(id: 10, testPic: "image11", testTitle: "Film 11", testYear: "2011", testRating: "5.1", isliked: true),
        Item(id: 11, testPic: "image12", testTitle: "Film 12", testYear: "2012", testRating: "5.2", isliked: true),
        Item(id: 12, testPic: "image13", testTitle: "Film 13", testYear: "2013", testRating: "5.3", isliked: false),
        Item(id: 13, testPic: "image14", testTitle: "Film 14", testYear: "2014", testRating: "5.4", isliked: false),
        Item(id: 14, testPic: "image15", testTitle: "Film 15", testYear: "2015", testRating: "5.5", isliked: true)
    ]
    
    var newTestArray: [Item] = []
    
    var likedTestArray: [Item] = []
    
    var sortAscending: Bool = true
    
    func ratingSort() {
        self.testArray.sort {
            sortAscending ? ($0.testRating ?? 0) < ($1.testRating ?? 0) : ($0.testRating ?? 0) > ($1.testRating ?? 0)
        }
        newTestArray = testArray
    }
    
    func showLikedFilms() {
        for item in testArray {
            if item.isLiked == true {
                self.likedTestArray.append(item)
            }
        }
    }
    
    func search(searchTextValue: String) {
        newTestArray = []
        
        if searchTextValue == "" {
            newTestArray = testArray
        } else {
            for item in testArray {
                guard let unwrItem = item.testTitle else {
                    return
                }
                if unwrItem.contains(searchTextValue) {
                    newTestArray.append(item)
                }
            }
        }
        newTestArray = testArray.filter({
            $0.testTitle?.range(of: searchTextValue, options: .caseInsensitive) != nil
        })
    }
    
    // MARK: - CollectionViewItems Methods
    
    func countItems() -> Int {
        newTestArray.count
    }
    
    func buuildCell(cell: FilmCollectionViewCell, indexPath: IndexPath) -> UICollectionViewCell {
        
        cell.posterImageView.image = UIImage(named: newTestArray[indexPath.row].testPic ?? "image01")
        cell.filmTitleLabel.text = newTestArray[indexPath.row].testTitle
        cell.yearLabel.text = newTestArray[indexPath.row].testYear
        cell.ratingLabel.text = newTestArray[indexPath.row].testRating
        
        return cell
    }
}
