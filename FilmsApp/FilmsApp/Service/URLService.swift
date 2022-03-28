// Popular:
// https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=en-US&page=1

// Latest:
// https://api.themoviedb.org/3/movie/latest?api_key=<<api_key>>&language=en-US

// Now Playing:
// https://api.themoviedb.org/3/movie/now_playing?api_key=<<api_key>>&language=en-US&page=1

// Top Rated:
// https://api.themoviedb.org/3/movie/top_rated?api_key=<<api_key>>&language=en-US&page=1

// Upcoming:
// https://api.themoviedb.org/3/movie/upcoming?api_key=<<api_key>>&language=en-US&page=1


import Foundation

enum ApiRequest: String {
    case latest = "latest"
    case popular = "popular"
    case nowPlaying = "now_playing"
    case topRated = "top_rated"
    case upcoming = "upcoming"
    
    var urlEnd: String {
        return self.rawValue == "latest" ? "" : "&page=1"
    }
}

class URLService {
    
    let apiKey: String = "a7e7734795f96137ff3605cc57a01ddb"
    let urlBase: String = "https://api.themoviedb.org/3/movie/"
    let session = URLSession.shared
    
    func dataRequest(request: ApiRequest) {
        
        let urlString = "\(urlBase)\(request.rawValue)?api_key=\(apiKey)&language=en-US\(request.urlEnd)"
        
        guard let apiURL: URL = URL(string: urlString) else { return }
        
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let unwrData = data,
                  let dataString = String(data: unwrData, encoding: .utf8),
                  (response as? HTTPURLResponse)?.statusCode == 200,
                  error == nil else {
                return
            }
            print("🟢 dataString for request \(request.rawValue):")
            print(dataString)
        }
        task.resume()
    }
}
