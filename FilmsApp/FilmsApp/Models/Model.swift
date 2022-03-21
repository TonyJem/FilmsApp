import Foundation

class Model {
    var testArray: [Film] = [
        Film(id: 1, testPic: "image01", testTitle: "Film 01", testYear: "2001", testRating: "4.1", isliked: true),
        Film(id: 2, testPic: "image02", testTitle: "Film 02", testYear: "2002", testRating: "4.2", isliked: false),
        Film(id: 3, testPic: "image03", testTitle: "Film 03", testYear: "2003", testRating: "4.3", isliked: true),
        Film(id: 4, testPic: "image04", testTitle: "Film 04", testYear: "2004", testRating: "4.4", isliked: true),
        Film(id: 5, testPic: "image05", testTitle: "Film 05", testYear: "2005", testRating: "4.5", isliked: false),
        Film(id: 6, testPic: "image06", testTitle: "Film 06", testYear: "2006", testRating: "4.6", isliked: true),
        Film(id: 7, testPic: "image07", testTitle: "Film 07", testYear: "2007", testRating: "4.7", isliked: true),
        Film(id: 8, testPic: "image08", testTitle: "Film 08", testYear: "2008", testRating: "4.8", isliked: false),
        Film(id: 9, testPic: "image09", testTitle: "Film 09", testYear: "2009", testRating: "4.9", isliked: true),
        Film(id: 10, testPic: "image10", testTitle: "Film 10", testYear: "2010", testRating: "5.0", isliked: false),
        Film(id: 11, testPic: "image11", testTitle: "Film 11", testYear: "2011", testRating: "5.1", isliked: true),
        Film(id: 12, testPic: "image12", testTitle: "Film 12", testYear: "2012", testRating: "5.2", isliked: true),
        Film(id: 13, testPic: "image13", testTitle: "Film 13", testYear: "2013", testRating: "5.3", isliked: false),
        Film(id: 14, testPic: "image14", testTitle: "Film 14", testYear: "2014", testRating: "5.4", isliked: false),
        Film(id: 15, testPic: "image15", testTitle: "Film 15", testYear: "2015", testRating: "5.5", isliked: true)
    ]
    
    var likedFilms: [Film] {
        var likedFilms: [Film] = []
        for film in testArray {
            if film.isLiked == true {
                likedFilms.append(film)
            }
        }
        return likedFilms
    }
}

class Film {
    var id: Int?
    var testPic: String?
    var testTitle: String?
    var testYear: String?
    var testRating: String?
    var isLiked: Bool
    
    init(id: Int? = nil, testPic: String?, testTitle: String?, testYear: String?, testRating: String?, isliked: Bool = false) {
        self.id = id
        self.testPic = testPic
        self.testTitle = testTitle
        self.testYear = testYear
        self.testRating = testRating
        self.isLiked = isliked
    }
}
