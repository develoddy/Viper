
import UIKit

class SearchViewData: NSObject {
    var id: Int
    var content, createdAt: String
    var user: User
    var images: [Image]
    var comments: [Comment]
    var hearts: [Heart]
    
    init(info: Post) {
        self.id = info.id ?? 0
        self.content = info.content ?? ""
        self.createdAt = info.createdAt ?? ""
        self.user = info.user!
        self.images = info.images!
        self.comments = info.comments!
        self.hearts = info.hearts!
    }
}
