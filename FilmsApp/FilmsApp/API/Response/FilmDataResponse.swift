import Foundation

// MARK: - ScreenShots
struct FilmDataResponse: Codable {
    let id: Int
    let backdrops: [BackdropResponse]
}

// MARK: - Backdrop
struct BackdropResponse: Codable {
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
