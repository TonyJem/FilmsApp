import Foundation

// MARK: - MovieList
struct MovieList: Codable {
    let page: Int
    let results: [Result]
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let id: Int?
    let posterPath: String?
    let originalTitle: String?
    let overview: String?
    let releaseDate: String?
    let voteAverage: Double?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let screenShots = try? newJSONDecoder().decode(ScreenShots.self, from: jsonData)

// MARK: - ScreenShots
struct ScreenShots: Codable {
    let id: Int
    let backdrops: [Backdrop]
    let posters: [Backdrop]
}

// MARK: - Backdrop
struct Backdrop: Codable {
    let aspectRatio: Double
    let filePath: String
    let height: Int
    let width: Int
    
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case width
    }
}
