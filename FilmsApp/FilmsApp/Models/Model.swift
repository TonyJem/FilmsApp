import UIKit
import RealmSwift

class Model {
    
    let realm = try? Realm()
    
    var isSortedAscending: Bool = false
    
    var films: Results<FilmObject>? {
        
        let allFilmsFromDB = realm?.objects(FilmObject.self)
        let filmsSorted = allFilmsFromDB?.sorted(byKeyPath: "filmRating", ascending: isSortedAscending)
        
        guard let searchText = searchTextValue else {
            return filmsSorted
        }
        let predicate = NSPredicate(format: "filmTitle CONTAINS [c]%@", searchText)
        return filmsSorted?.filter(predicate)
    }
    
    var likedFilms: Results<LikedFilmObject>? {
        return realm?.objects(LikedFilmObject.self)
    }
    
    private var searchTextValue: String?
    
    
    // MARK: - Public Methods
    func search(searchTextValue: String?) {
        self.searchTextValue = searchTextValue
    }
    
    func cancelSearch() {
        self.searchTextValue = nil
    }
    
    func changeSortDirection() {
        isSortedAscending = !isSortedAscending
    }
    
    func updateLikeFor(film: FilmObject) {
        do {
            try realm?.write ({
                film.isLikedByUser = !film.isLikedByUser
            })
        } catch {
            print("🔴 Error saving done status, \(error)")
        }
    }
    
    
    
    
    // MARK: - OLD Public Methods (need to Refactor it)
    func deleteLikedItem(at item: Int) {
        do {
            try realm?.write({
                
                if let likedArray = likedFilms, let likedObject = likedFilms?[item] {
                    likedObject.isLikedByUser = !likedObject.isLikedByUser
                    
                    for i in likedArray {
                        if i.isLikedByUser == false {
                            realm?.delete(i)
                        }
                    }
                }
            })
        } catch {
            print("Error saving done status, \(error)")
        }
    }
    
    func updateLikeFor(item: Int) {
        print("🟢 updateLikeFor Did Tap in Model")
    }
}
