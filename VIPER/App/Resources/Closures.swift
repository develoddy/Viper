import UIKit

class Closures: NSObject {
    typealias Login = (_ response: LoginToken?) -> Void
    typealias Posts = (_ response: ResPosts?) -> Void
    typealias heart = (_ response: Heart?) -> Void
    typealias resMessage = (_ response: ResMessage?) -> Void
    typealias checkHeart = (_ response: [Heart]?) -> Void
    typealias resUser = (_ response: ResUser?) -> Void
    typealias resCounter = (_ response: ResCounter?) -> Void
    typealias resFollows = (_ response: ResFollows?) -> Void
    typealias comments = (_ response: [Comment]?) -> Void
    typealias upcomment = (_ response: [Int]?) -> Void
    typealias user = (_ response: [User]?) -> Void
    
    typealias MessageError = (_ messageError: String ) -> Void
    typealias Message = (_ message: Operation ) -> Void
}
