import Foundation
import RealmSwift

class JSONParsingService {
    
    func parseJSON(parseData: Data, parseError: Error?) {
        do {
            let filmObject = try JSONDecoder().decode(MovieList.self, from: parseData)
            
            let jsonObjects = filmObject.results
            let realm = try? Realm()
            
            // Write data to DB
            try realm?.write({
                // Loop for JSON Objects array
                for item in jsonObjects {
                    let object = FilmObject()
                    
                    if let unwrID = item.id,
                       let unwrPoster = item.posterPath,
                       let unwrOrigTitle = item.originalTitle,
                       let unwrAbout = item.overview,
                       let unwrReleaseYear = item.releaseDate,
                       let unwrFilmRating = item.voteAverage {
                        
                        object.id = unwrID
                        object.filmPic = unwrPoster
                        object.filmTitle = unwrOrigTitle
                        object.about = unwrAbout
                        object.releaseYear = Int(unwrReleaseYear.prefix(4)) ?? 0000
                        object.filmRating = unwrFilmRating
                        
                        //object.screenshots = item.backdrop_path ?? "N/A"
                        //object.isLikedByUser = newOne.isLikedByUser
                    }
                    realm?.add(object, update: .all)
                }
            })
            
        } catch let error {
            print(error)
        }
    }
    
}
