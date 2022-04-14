import Foundation
import RealmSwift

struct Film {
    let id: Int
    let filmPic: String
    let filmTitle: String
    let about: String
    let releaseYear: Int
    let filmRating: Double
    let isLikedByUser: Bool
    
    init(from film: FilmObject) {
        id = film.id
        filmPic = film.filmPic
        filmTitle = film.filmTitle
        about = film.about
        releaseYear = film.releaseYear
        filmRating = film.filmRating
        isLikedByUser = film.isLikedByUser
    }
}

class FilmObject: Object {
    @Persisted var id: Int = 0
    @Persisted var filmPic: String = ""
    @Persisted var filmTitle: String = ""
    @Persisted var about: String = ""
    @Persisted var releaseYear: Int = 0
    @Persisted var filmRating: Double = 0.0
    @Persisted var screenshots: List<String> = List<String>()
    @Persisted var isLikedByUser: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class LikedFilmObject: Object {
    @Persisted var id: Int = 0
    @Persisted var filmPic: String = ""
    @Persisted var filmTitle: String = ""
    @Persisted var about: String = ""
    @Persisted var releaseYear: Int = 0
    @Persisted var filmRating: Double = 0.0
    @Persisted var screenshots: List<String> = List<String>()
    @Persisted var isLikedByUser: Bool = true
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
