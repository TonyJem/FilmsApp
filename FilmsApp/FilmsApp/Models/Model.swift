import Foundation
import UIKit
import RealmSwift

class Model {
    
    let realm = try? Realm()
    
    var filmObjects: Results<FilmObject>? {
        return realm?.objects(FilmObject.self)
    }
    
    var likedFilmObjects: Results<LikedFilmObject>? {
        return realm?.objects(LikedFilmObject.self)
    }
    
    var arrayHelper: Results<FilmObject>?
    
    var sortAscending: Bool = true
    
    func search(searchTextValue: String) {
        let predicate = NSPredicate(format: "filmTitle CONTAINS [c]%@", searchTextValue)
        arrayHelper = filmObjects?.filter(predicate)
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
    
    // объявили функцию с входным параметром
    func updateLike(at item: Int) {
        var localChecker: [FilmObject] = []
        // сделали optional binding для объекта
        if let film = filmObjects?[item],
           let array = filmObjects{
            // блок do/catch
            let object = LikedFilmObject()
            do {
                // запись в объект по "индексу" item
                try realm?.write ({
                    // переворачиваем первоначальное значение лайка
                    film.isLikedByUser = !film.isLikedByUser
                    
                    for i in array {
                        if i.isLikedByUser == true {
                            localChecker.append(i)
                        }
                    }
                    
                    for el in localChecker {
                        object.id = el.id
                        object.filmPic = el.filmPic
                        object.filmTitle = el.filmTitle
                        object.about = el.about
                        object.releaseYear = el.releaseYear
                        object.filmRating = el.filmRating
                        
                        realm?.add(object, update: .all)
                    }
                })
            } catch {
                // обрабатываем ошибки
                print("Error saving done status, \(error)")
            }
        }
    }
}
