import UIKit

class LoginViewData: NSObject {
    let success: String
    let user: UserLogin
    
    init(info: LoginToken) {
        self.success = info.success ?? ""
        self.user = info.user!
    }
    
}
