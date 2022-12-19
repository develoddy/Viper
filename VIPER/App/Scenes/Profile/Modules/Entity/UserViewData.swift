
import UIKit

class UserViewData: NSObject {
    var id: Int
    var name, username, email: String
    var bio: String
    var imageHeader: String
    
    init(info: User) {
        self.id = info.id!
        self.name = info.name!
        self.username = info.username!
        self.email = info.email!
        self.imageHeader = info.profile?.imageHeader ?? ""
        self.bio = info.profile?.bio ?? ""
    }
}
