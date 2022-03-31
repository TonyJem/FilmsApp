import Foundation
import UIKit
import RealmSwift

class Model {
    
    let realm = try? Realm()
    
    var filmObjects: Results<FilmObject>? {
        return realm?.objects(FilmObject.self)
    }
    
    var likedFilmObjects: Results<LikedFilmObject>?
    var arrayHelper: Results<FilmObject>?
    var sortAscending: Bool = true
    
    func ratingSort() {
        arrayHelper = filmObjects?.sorted(byKeyPath: "filmRating", ascending: sortAscending)
    }
    
    func search(searchTextValue: String) {
        let predicate = NSPredicate(format: "filmTitle CONTAINS [c]%@", searchTextValue)
        arrayHelper = filmObjects?.filter(predicate)
    }
    
    func updateLike(at item: Int) {
        if let film = filmObjects?[item] {
            do {
                try realm?.write {
                    film.isLikedByUser = !film.isLikedByUser
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
    }
    
    func changeColor(at sender: UIButton) {
        sender.backgroundColor = .red
    }
}
