import RealmSwift

class FilmObject: Object {
    @Persisted var id: Int = 0
    @Persisted var filmPic: String = ""
    @Persisted var filmTitle: String = ""
    @Persisted var about: String = ""
    @Persisted var releaseYear: Int = 0
    @Persisted var filmRating: Double = 0.0
    @Persisted var screens: String = ""
    @Persisted var isLikedByUser: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
