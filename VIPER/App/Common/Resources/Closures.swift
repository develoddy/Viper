import UIKit

class Closures: NSObject {
    typealias Login = (_ response: LoginToken?) -> Void
    typealias Posts = (_ response: ResPosts?) -> Void
    typealias heart = (_ response: Heart?) -> Void
    typealias resMessage = (_ response: ResMessage?) -> Void
    typealias checkHeart = (_ response: [Heart]?) -> Void
    
    typealias MessageError = (_ messageError: String ) -> Void
    typealias Message = (_ message: Operation ) -> Void
}
