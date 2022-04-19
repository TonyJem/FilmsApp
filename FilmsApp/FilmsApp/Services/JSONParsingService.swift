import Foundation
import RealmSwift

class JSONParsingService {
    
    func parseJSON(parseData: Data, parseError: Error?) {
        do {
            let filmObject = try JSONDecoder().decode(MovieList.self, from: parseData)
            let jsonObjects = filmObject.results
            let realm = try? Realm()
            
            try realm?.write({
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
                    }
                    realm?.add(object, update: .all)
                }
            })
        } catch let error {
            print(error)
        }
    }
    
    func parseJSONwithScreens(parseData: Data, parseError: Error?) {
        do {
            let filmData = try JSONDecoder().decode(FilmData.self, from: parseData)
            let filmID = filmData.id
            let backdrops = filmData.backdrops
            
            var filmBackDrops: [String] = []
            
            for backdrop in backdrops {
                filmBackDrops.append(backdrop.filePath)
            }
            
            print("🟢🟢🟢 filmID: \(filmID)")
            print("🟢🟢🟢🟢 backdrops: \(filmBackDrops)")
            
        } catch let error {
            print(error)
        }
    }
    
}
