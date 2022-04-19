import Foundation

struct Core {
    static let model = Model()
    static let urlService = URLService()
    
    static let tempStorage = TempStorage()
}


class TempStorage {
    var screenshots: [String] = []
}
