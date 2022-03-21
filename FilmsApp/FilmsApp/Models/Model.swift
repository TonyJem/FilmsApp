import Foundation

class Model {
    var testArray: [Item] = [
        Item(testPic: "image01", testTitle: "Film 01", testYear: "2001", testRating: "4.1"),
        Item(testPic: "image02", testTitle: "Film 02", testYear: "2002", testRating: "4.2"),
        Item(testPic: "image03", testTitle: "Film 03", testYear: "2003", testRating: "4.3"),
        Item(testPic: "image04", testTitle: "Film 04", testYear: "2004", testRating: "4.4"),
        Item(testPic: "image05", testTitle: "Film 05", testYear: "2005", testRating: "4.5"),
        Item(testPic: "image06", testTitle: "Film 06", testYear: "2006", testRating: "4.6"),
        Item(testPic: "image07", testTitle: "Film 07", testYear: "2007", testRating: "4.7"),
        Item(testPic: "image08", testTitle: "Film 08", testYear: "2008", testRating: "4.8"),
        Item(testPic: "image09", testTitle: "Film 09", testYear: "2009", testRating: "4.9"),
        Item(testPic: "image10", testTitle: "Film 10", testYear: "2010", testRating: "5.0"),
        Item(testPic: "image11", testTitle: "Film 11", testYear: "2011", testRating: "5.1"),
        Item(testPic: "image12", testTitle: "Film 12", testYear: "2012", testRating: "5.2"),
        Item(testPic: "image13", testTitle: "Film 13", testYear: "2013", testRating: "5.3"),
        Item(testPic: "image14", testTitle: "Film 14", testYear: "2014", testRating: "5.4"),
        Item(testPic: "image15", testTitle: "Film 15", testYear: "2015", testRating: "5.5")
    ]
}

class Item {
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
