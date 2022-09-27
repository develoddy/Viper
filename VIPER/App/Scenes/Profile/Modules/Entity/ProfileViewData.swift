import UIKit

class ProfileViewData: NSObject {
    var bio: String
    var imageHeader: String
    
    init(info: Profile) {
        self.bio = info.bio!
        self.imageHeader = info.imageHeader!
        
    }
}
