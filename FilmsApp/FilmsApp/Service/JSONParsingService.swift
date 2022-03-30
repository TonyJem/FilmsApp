import Foundation
import RealmSwift

class JSONParsingService {
    
    //    let model = Model()
    
    func parseJSON(parseData: Data, parseError: Error?) {
        do {
            let filmObject = try JSONDecoder().decode(MovieList.self, from: parseData)
            print("🟢 Object with films - \(filmObject.results[0].originalTitle)")
            
            let jsonObjects = filmObject.results
            let realm = try? Realm()
            
            // Write data to DB
            try realm?.write({
                // Loop for JSON Objects array
                for item in jsonObjects {
                    let object = FilmObject()
                    
                    object.id = item.id
                    object.filmPic = item.posterPath
                    object.filmTitle = item.originalTitle
                    object.about = item.overview
                    object.releaseYear = Int(item.releaseDate.prefix(4)) ?? 0
                    object.filmRating = item.voteAverage
                    object.screens = item.backdropPath
                    object.isLikedByUser = false
                    
                    // Update objects, so do not re-create them again
                    realm?.add(object, update: .all)
                }
            })
            
        } catch let error {
            print(error)
        }
    }
    
}
