import Foundation

class URLService {
    
    let apiKey: String = ""
    let session = URLSession.shared
    
    func dataRequest() {
        
        guard let apiURL: URL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1") else {
            return
        }
        
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let unwrData = data,
                  let dataString = String(data: unwrData, encoding: .utf8),
                  (response as? HTTPURLResponse)?.statusCode == 200,
                  error == nil else {
                return
            }
            print("🟢 dataString:")
            print(dataString)
        }
        task.resume()
    }
}
