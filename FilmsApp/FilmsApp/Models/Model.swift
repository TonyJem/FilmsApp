import UIKit
import RealmSwift

class Model {
    
    let realm = try? Realm()
    
    var isSortedAscending: Bool = false
    
    var films: Results<FilmObject>? {
        let filmsSorted = fetchedFilms?.sorted(byKeyPath: "filmRating", ascending: isSortedAscending)
        
        guard let searchText = searchTextValue else {
            return filmsSorted
        }
        let predicate = NSPredicate(format: "filmTitle CONTAINS [c]%@", searchText)
        return filmsSorted?.filter(predicate)
    }
    
    var likedFilmObjects: Results<LikedFilmObject>? {
        return realm?.objects(LikedFilmObject.self)
    }
    
    private var searchTextValue: String?
    
    private var fetchedFilms: Results<FilmObject>? {
        return realm?.objects(FilmObject.self)
    }
    
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
    
    func deleteLikedItem(at item: Int) {
        do {
            try realm?.write({
                
                if let likedArray = likedFilmObjects, let likedObject = likedFilmObjects?[item] {
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
    
    func updateLikeFor(film: FilmObject) {
        do {
            try realm?.write ({
                film.isLikedByUser = !film.isLikedByUser
            })
        } catch {
            print("🔴 Error saving done status, \(error)")
        }
        
    }
}
