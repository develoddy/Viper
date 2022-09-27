// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let resPostImages = try? newJSONDecoder().decode(ResPostImages.self, from: jsonData)

import Foundation


// MARK: - ResPosts
struct ResPosts: Codable {
    let resPostImages: ResPostImages?
    let commentCounts: [CommentCount]?

    enum CodingKeys: String, CodingKey {
        case resPostImages = "ResPostImages"
        case commentCounts
    }
}

// MARK: - CommentCount
struct CommentCount: Codable {
    let postID, comentarios: Int?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case comentarios
    }
}

// MARK: - ResPostImages
struct ResPostImages: Codable {
    let totalItems: Int?
    let posts: [Post]?
    let totalPages, currentPage, limit: Int
}

// MARK: - Post
struct Post: Codable {
    let id: Int?
    var content, createdAt: String?
    let user: User?
    let images: [Image]?
    var comments: [Comment]?
    let hearts: [Heart]?

    enum CodingKeys: String, CodingKey {
        case id, content
        case createdAt = "created_at"
        case user, images, comments, hearts
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id, userID, postId: Int?
    var content: String?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case postId = "postId"
        case content, user
    }
}

// MARK: - CommentPost
struct CommentPost: Codable {
    let typeID, refID, user_id: Int?
    let content: String?
    let commentID: Int?
    let createdAt, updatedAt: String?
    let postID, userID: Int?

    enum CodingKeys: String, CodingKey {
        case typeID = "type_id"
        case refID = "ref_id"
        case user_id = "user_id"
        case content
        case commentID = "comment_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case postID = "postId"
        case userID = "userId"
    }
}


// MARK: - User
struct User: Codable {
    let id: Int?
    let name, username, email: String?
    let profile: Profile?
}

// MARK: - Profile
struct Profile: Codable {
    let bio, imageHeader: String?

    enum CodingKeys: String, CodingKey {
        case bio
        case imageHeader = "image_header"
    }
}

// MARK: - Image
struct Image: Codable {
    let title, src: String?
    let postImage: PostImage?

    enum CodingKeys: String, CodingKey {
        case title, src
        case postImage = "post_image"
    }
}

// MARK: - PostImage
struct PostImage: Codable {
    let postID, imageID: Int?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case imageID = "imageId"
    }
}

// MARK: - ResFollows
struct ResFollows: Codable {
    let totalItems: Int?
    let follows: [Follow]?
    let totalPages, currentPage: Int
}

// MARK: - Follow
struct Follow: Codable {
    let id: Int?
    let name, username: String?
    let profile: Profile?
}

// MARK: - Like
struct Heart: Codable {
    let id, typeID, refID, userID: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case typeID = "type_id"
        case refID = "ref_id"
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}




// MARK: - ResUser
struct ResUser: Codable {
    let user: User?
    let follow: ResFollow?
}

// MARK: - Follow
struct ResFollow: Codable {
    let userID, followedID: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case followedID = "followed_id"
    }
}

// MARK: - ResMessage
struct ResMessage: Codable {
    let message: Bool?
}







// MARK: - Post Render
/*enum PostRenderType {
    case header(provider: Post)
    case primaryContent(provider: Post)
    case actions(provider: Post)
    case descriptions(post: Post)
    case comments(comments: [Comment])
    //case footer(footer: Post)
}

struct PostRenderViewModel {
    let renderType: PostRenderType
}

struct HomeFeedRenderViewModel {
    //let collections: PostRenderViewModel
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let descriptions: PostRenderViewModel
    let comments: PostRenderViewModel
    //let footer: PostRenderViewModel
}*/




// MARK: - Login
struct LoginToken: Codable {
    let success: String?
    let user: UserLogin?
}

// MARK: - User
struct UserLogin: Codable {
    let id: Int?
    let name, lastname, username, email: String?
    let code: String?
    let isActive, isAdmin: Bool?
    let createdAt, updatedAt: String?
    let profile: ProfileLogin?

    enum CodingKeys: String, CodingKey {
        case id, name, lastname, username, email, code
        case isActive = "is_active"
        case isAdmin = "is_admin"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case profile
    }
}

// MARK: - Profile
struct ProfileLogin: Codable {
    let bio, imageHeader: String?

    enum CodingKeys: String, CodingKey {
        case bio
        case imageHeader = "image_header"
    }
}


// MARK: - Message
struct Operation: Codable {
    let store: String?
}



// MARK: - Counter
struct ResCounter: Codable {
    let following, followed, posts: Int
}







//// MARK: - UserBE
class UserBE: NSObject, NSCoding {
    var name                : String?
    var username            : String?
    var email               : String?
    var password            : String?

    override init() {
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        self.name      = aDecoder.decodeObject(forKey: "name")     as? String
        self.username  = aDecoder.decodeObject(forKey: "username") as? String
        self.email     = aDecoder.decodeObject(forKey: "email")    as? String
        self.password  = aDecoder.decodeObject(forKey: "password") as? String
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name,     forKey: "name")
        aCoder.encode(self.username, forKey: "username")
        aCoder.encode(self.email,    forKey: "email")
        aCoder.encode(self.password, forKey: "password")
    }
}




///* ============================================ */
///* ==     [ W E B  -  R E S P O N S E ]      == */
///* ============================================ */
//
// MARK: - Web Response
class WebResponse: NSObject {
    var respuestaJSON   : Any?
    var statusCode      : NSInteger?
    var respuestaNSData : Data?
    var error           : NSError?
    var datosCabecera   : NSDictionary?
    var token           : NSString?
    var cookie          : NSString?
}
