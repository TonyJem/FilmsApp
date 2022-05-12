import Foundation

enum APIEndpoint {
    case images
    
    var url: URL? {
        switch self {
        case .images:
            return makeURL(endpoint: "/images?api_key=")
        }
    }
}


//let idString = String(id)

// https://api.themoviedb.org/3/movie/{movie_id}/images?api_key=<<api_key>>
private extension APIEndpoint {
    
    var baseURL: String {
        "https://api.themoviedb.org/3/movie/"
    }
    
    var apiKey: String {
        "a7e7734795f96137ff3605cc57a01ddb"
    }
    
    func makeURL(for id: Int, with endpoint: String) -> URL? {
        let idString = String(id)
        return URL(string: baseURL + idString + endpoint + apiKey)
    }
}
