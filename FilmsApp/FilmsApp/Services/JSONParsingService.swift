import Foundation
import RealmSwift

class JSONParsingService {
    
    func parseJSON(parseData: Data, parseError: Error?) {
        do {
            let movieList = try JSONDecoder().decode(MovieList.self, from: parseData)
            let results = movieList.results
            let realm = try? Realm()
            
            try realm?.write({
                for result in results {
                    let object = FilmObject()
                    
                    if let id = result.id,
                       let posterPath = result.posterPath,
                       let originalTitle = result.originalTitle,
                       let overview = result.overview,
                       let releaseDate = result.releaseDate,
                       let voteAverage = result.voteAverage {
                        
                        object.id = id
                        object.filmPic = posterPath
                        object.filmTitle = originalTitle
                        object.about = overview
                        object.releaseYear = Int(releaseDate.prefix(4)) ?? 0000
                        object.filmRating = voteAverage
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
            
            Core.tempStorage.screenshots = []
            Core.tempStorage.screenshots = filmBackDrops
            
        } catch let error {
            print(error)
        }
    }
    
}
