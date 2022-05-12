import Foundation

enum APIEndpoint {
    case imagesPaths
    
    var url: URL? {
        switch self {
        case .imagesPaths:
            return makeURL(endpoint: "endpoint")
        }
    }
}


// https://api.themoviedb.org/3/movie/{movie_id}/images?api_key=<<api_key>>
private extension APIEndpoint {
    
    var baseURL: String {
        "https://api.themoviedb.org/3/movie/"
    }
    
    var apiKey: String {
        "a7e7734795f96137ff3605cc57a01ddb"
    }
    
    func makeURL(endpoint: String) -> URL? {
        return URL(string: baseURL + endpoint)
    }
}
