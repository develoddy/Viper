

import UIKit

class CommentViewData: NSObject {
    var id, userID, postId: Int
    var content: String
    var user: User
    
    init(info: Comment) {
        self.id = info.id ?? 0
        self.userID = info.userID ?? 0
        self.postId = info.postId ?? 0
        self.content = info.content ?? ""
        self.user = info.user!
    }
}
