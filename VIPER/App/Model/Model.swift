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
    let content, createdAt: String?
    let user: User?
    let images: [Image]?
    let comments: [Comment]?

    enum CodingKeys: String, CodingKey {
        case id, content
        case createdAt = "created_at"
        case user, images, comments
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id, userID, commentID: Int?
    let content: String?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case commentID = "commentId"
        case content, user
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







// MARK: - Post Render
enum PostRenderType {
    case header(provider: Post)
    case primaryContent(provider: Post)
    case actions(provider: Post)
    case descriptions(post: Post)
    case comments(comments: [Comment])
    case footer(footer: Post)
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
    let footer: PostRenderViewModel
}






//MARK: - PROFILE BY ONE
// MARK: - ResUF
struct ResUF: Codable {
    let user: User?
    let follow: Follow?
}

// MARK: - Follow
struct Follow: Codable {
    let userID, followedID: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case followedID = "followed_id"
    }
}







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










//import Foundation
//
//
//struct Login: Codable {
//    let success: String?
//    let usertoken: User?
//
//    enum CodingKeys: String, CodingKey {
//        case success
//        case usertoken
//    }
//}
//
//
//
////MARK: -
//// MARK: - ResProfileFollow
//struct ResProfileFollow: Codable {
//    let resProfile: ResProfile
//    let usersFollowing, usersFollowed: [Int]
//
//    enum CodingKeys: String, CodingKey {
//        case resProfile = "res_profile"
//        case usersFollowing = "users_following"
//        case usersFollowed = "users_followed"
//    }
//}
//
//// MARK: - ResProfile
//struct ResProfile: Codable {
//    let totalItems: Int
//    let profiles: [Profile]
//    let totalPages, currentPage: Int
//}
//
//// MARK: - Profile
//struct Profile: Codable {
//    let id: Int
//    let dayOfBirth, gender: String?
//    let countryID: Int
//    let image, imageHeader: String
//    let title: String?
//    let bio: String
//    let likes, dislikes, address: String?
//    let phone, publicEmail: String
//    let userID, levelID: Int
//    let sentimentalID, createdAt, updatedAt: String?
//    let user: User?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case dayOfBirth = "day_of_birth"
//        case gender
//        case countryID = "country_id"
//        case image
//        case imageHeader = "image_header"
//        case title, bio, likes, dislikes, address, phone
//        case publicEmail = "public_email"
//        case userID = "user_id"
//        case levelID = "level_id"
//        case sentimentalID = "sentimental_id"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case user
//    }
//}
//
//// MARK: - User
//struct User: Codable {
//    let id: Int
//    let name: String
//    let lastname: String?
//    let username, email, password: String
//    let code: String?
//    let isActive, isAdmin: Bool
//    let createdAt, updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, lastname, username, email, password, code
//        case isActive = "is_active"
//        case isAdmin = "is_admin"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}
//
//
//
//
//
//
//
//// MARK: -
//
//enum PostRenderType {
//    case header(provider: Userpost)
//}
//
//struct PostRenderViewModel {
//    let renderType: PostRenderType
//}
//
//struct HomeFeedRenderViewModel {
//    let header: PostRenderViewModel
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
////// MARK: - UserPostData
////struct UserPostData: Codable {
////    let status: Bool?
////    let userpost: [Userpost]?
////}
////
////// MARK: - Userpost
////struct Userpost: Codable {
////    let id: Int?
////    var title, content: String?
////    let lat, lng: Int?
////    let startAt, finishAt: String?
////    let receptorTypeID, authorRefID, receptorRefID, posttTypeID: Int?
////    let nivelID: Int?
////    let createdAt, updatedAt: String?
////    let idPostType: Int?
////    let comments: [Comment]?
////    var likes: [Like]?
////    let taggeds: [Tagged]?
////    let userAuthor: User?
////    let postImage: [PostImage]?
////    let postType: PostType?
////
////    enum CodingKeys: String, CodingKey {
////        case id, title, content, lat, lng
////        case startAt = "start_at"
////        case finishAt = "finish_at"
////        case receptorTypeID = "receptor_type_id"
////        case authorRefID = "author_ref_id"
////        case receptorRefID = "receptor_ref_id"
////        case posttTypeID = "postt_type_id"
////        case nivelID = "nivel_id"
////        case createdAt = "created_at"
////        case updatedAt = "updated_at"
////        case idPostType = "id_post_type"
////        case comments, likes, taggeds
////        case userAuthor = "user_author"
////        case postImage = "post_image"
////        case postType = "post_type"
////    }
////}
////
////// MARK: - Comment
////struct Comment: Codable {
////    let id, typeID, refID: Int?
////    let content: String?
////    let usersID, comentarioID: Int?
////    let createdAt, updatedAt: String?
////    let user: User?
////
////    enum CodingKeys: String, CodingKey {
////        case id
////        case typeID = "type_id"
////        case refID = "ref_id"
////        case content
////        case usersID = "users_id"
////        case comentarioID = "comentario_id"
////        case createdAt = "created_at"
////        case updatedAt = "updated_at"
////        case user
////    }
////}
////
////// MARK: - User
//// struct User: Codable {
////    let id: Int?
////    let name: String?
////    let username: String?
////    let email: String?
////    let emailVerifiedAt: String?
////    let idCount: Int?
////    let createdAt, updatedAt: String?
////    let count: Count?
////    let profile: Profile?
////
////    enum CodingKeys: String, CodingKey {
////        case id, name, username, email
////        case emailVerifiedAt = "email_verified_at"
////        case idCount = "id_count"
////        case createdAt = "created_at"
////        case updatedAt = "updated_at"
////        case count, profile
////    }
////}
////
////// MARK: - Count
////struct Count: Codable {
////    let id, followers, following, posts: Int?
////    let createdAt, updatedAt: String?
////
////    enum CodingKeys: String, CodingKey {
////        case id, followers, following, posts
////        case createdAt = "created_at"
////        case updatedAt = "updated_at"
////    }
////}
////
////// MARK: - Profile
////struct Profile: Codable {
////    let id: Int?
////    let dayOfBirth, gender, image: String?
////    let imageHeader: String?
////    let title, bio, likes, dislikes: String?
////    let address, phone: String?
////    let publicEmail: String?
////    let data, valor: String?
////    let usersID, countryID, nivelID, sentimentalID: Int?
////    let createdAt, updatedAt: String?
////    let storyfeatured: [Storyfeatured]?
////
////    enum CodingKeys: String, CodingKey {
////        case id
////        case dayOfBirth = "day_of_birth"
////        case gender, image
////        case imageHeader = "image_header"
////        case title, bio, likes, dislikes, address, phone
////        case publicEmail = "public_email"
////        case data, valor
////        case usersID = "users_id"
////        case countryID = "country_id"
////        case nivelID = "nivel_id"
////        case sentimentalID = "sentimental_id"
////        case createdAt = "created_at"
////        case updatedAt = "updated_at"
////        case storyfeatured
////    }
////}
////
////// MARK: - Storyfeatured
////struct Storyfeatured: Codable {
////    let id: Int?
////    let title: String?
////    let src: String?
////    let userID: Int?
////    let createdAt, updatedAt: String?
////
////    enum CodingKeys: String, CodingKey {
////        case id, title, src
////        case userID = "user_id"
////        case createdAt = "created_at"
////        case updatedAt = "updated_at"
////    }
////}
////
////// MARK: - Like
////struct Like: Codable {
////    let id, typeID, refID, usersID: Int?
////    let createdAt, updatedAt: String?
////    let userlike: User?
////
////    enum CodingKeys: String, CodingKey {
////        case id
////        case typeID = "type_id"
////        case refID = "ref_id"
////        case usersID = "users_id"
////        case createdAt = "created_at"
////        case updatedAt = "updated_at"
////        case userlike
////    }
////}
////
////// MARK: - PostImage
////struct PostImage: Codable {
////    let postID, imageID: Int?
////    let createdAt, updatedAt: String?
////    let image: Image?
////
////    enum CodingKeys: String, CodingKey {
////        case postID = "post_id"
////        case imageID = "image_id"
////        case createdAt = "created_at"
////        case updatedAt = "updated_at"
////        case image
////    }
////}
////
////// MARK: - Image
////struct Image: Codable {
////    let id: Int?
////    let src: String?
////    let title, content: String?
////    let imageBin: String?
////    let albumID, usersID, nivelID: Int?
////    let createdAt, updatedAt: String?
////
////    enum CodingKeys: String, CodingKey {
////        case id, src, title, content
////        case imageBin = "image_bin"
////        case albumID = "album_id"
////        case usersID = "users_id"
////        case nivelID = "nivel_id"
////        case createdAt = "created_at"
////        case updatedAt = "updated_at"
////    }
////}
////
////// MARK: - PostType
////struct PostType: Codable {
////    let id: Int?
////    let photo, video: String?
////    let createdAt, updatedAt: String?
////
////    enum CodingKeys: String, CodingKey {
////        case id, photo, video
////        case createdAt = "created_at"
////        case updatedAt = "updated_at"
////    }
////}
////
////// MARK: - Tagged
////struct Tagged: Codable {
////    let id: Int?
////    let name, last, username, bio: String?
////    let profilePicture, dayOfBirth, publicEmail, joinDate: String?
////    let countryID: Int?
////    let image, imageHeader, title, likes: String?
////    let dislikes, address, phone: String?
////    let usersID, nivelID, sentimentalID: Int?
////    let imagenBin, valor: String?
////    let idPost, idGender, idCount: Int?
////    let createdAt, updatedAt: String?
////    let gender: Gender?
////
////    enum CodingKeys: String, CodingKey {
////        case id, name, last, username, bio
////        case profilePicture = "profile_picture"
////        case dayOfBirth = "day_of_birth"
////        case publicEmail = "public_email"
////        case joinDate = "join_date"
////        case countryID = "country_id"
////        case image
////        case imageHeader = "image_header"
////        case title, likes, dislikes, address, phone
////        case usersID = "users_id"
////        case nivelID = "nivel_id"
////        case sentimentalID = "sentimental_id"
////        case imagenBin = "imagen_bin"
////        case valor
////        case idPost = "id_post"
////        case idGender = "id_gender"
////        case idCount = "id_count"
////        case createdAt = "created_at"
////        case updatedAt = "updated_at"
////        case gender
////    }
////}
////
////// MARK: - Gender
////struct Gender: Codable {
////    let id: Int?
////    let gender: String?
////    let createdAt, updatedAt: String?
////
////    enum CodingKeys: String, CodingKey {
////        case id, gender
////        case createdAt = "created_at"
////        case updatedAt = "updated_at"
////    }
////}
////
////
////
////
////
////
////
////
////enum PostRenderType {
////    //case collections(collections: [CollectionTableCellModel], createStory: [CollectionTableCellModel])
////    case header(provider: Userpost)
////    case primaryContent(provider: Userpost)
////    case actions(provider: Userpost)
////    case descriptions(post: Userpost)
////    case comments(comments: [Comment])
////    case footer(footer: Userpost)
////}
////
/////// Model of  renderd Post
////struct PostRenderViewModel {
////    let renderType: PostRenderType
////}
////
////
//////MARK: - HomeFeedRenderViewModel
////struct HomeFeedRenderViewModel {
////    //let collections: PostRenderViewModel
////    let header: PostRenderViewModel
////    let post: PostRenderViewModel
////    let actions: PostRenderViewModel
////    let descriptions: PostRenderViewModel
////    let comments: PostRenderViewModel
////    let footer: PostRenderViewModel
////}
////
////
//
//
////// MARK: - Caption
//struct Caption: Codable {
//    var content: String?
//
//    enum CodingKeys: String, CodingKey {
//        case content
//    }
//}
//
//
/////* ============================================ */
/////* ==               [ T O K E N ]            == */
/////* ============================================ */
////
////// MARK: - ResponseTokenBE
////struct ResponseTokenBE: Codable {
////    let success: String?
////    let usertoken: Usertoken?
////
////    enum CodingKeys: String, CodingKey {
////        case success
////        case usertoken
////    }
////}
////
////// MARK: - User
////struct Usertoken: Codable {
////    let id: Int?
////    let lastname, code: String?
////    let isAdmin: Bool?
////    let username, email: String?
////    let createdAt, updatedAt: String?
////    let name: String?
////    let isActive: Bool?
////
////    enum CodingKeys: String, CodingKey {
////        case id, lastname, code
////        case isAdmin = "is_admin"
////        case username, email
////        case createdAt = "created_at"
////        case updatedAt = "updated_at"
////        case name
////        case isActive = "is_active"
////    }
////}
////
//
//
//
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
//
//// MARK: - LogOut
//class ResponseLogOutBE: NSObject, NSCoding {
//    var message : String?
//
//    override init() {
//        super.init()
//    }
//
//    required init(coder aDecoder: NSCoder) {
//        self.message = aDecoder.decodeObject(forKey: "message") as? String
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(self.message, forKey: "message")
//    }
//}
//
//
//
///* ============================================ */
///* ==           [ E X P L O R E ]            == */
///* ============================================ */
//
//// MARK:  - UserSearchBE
//class UserSearchBE: NSObject, NSCoding {
//    var name: String?
//
//    override init() {
//        super.init()
//    }
//
//    required init(coder aDecoder: NSCoder) {
//        self.name = aDecoder.decodeObject(forKey: "name") as? String
//    }
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(self.name, forKey: "name")
//    }
//}
//
//// MARK:  - WebUserSearchData
//struct WebUserSearchData: Codable {
//    var user: [UserDecodable]
//}
//
//// MARK:  - UserDecodable
//struct UserDecodable: Codable {
//    var username: String?
//    var name: String?
//}
//
//// MARK:  - WebUserModel
//struct WebUserModel {
//    var user: [Search]
//}
//
//// MARK:  - Search
//struct Search {
//    var username: String?
//    var name: String?
//}
//
//
//
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
//
//
//
//
//// MARK: - User
//struct PostContent: Codable {
//    let content: String?
//
//    enum CodingKeys: String, CodingKey {
//        case content = "content"
//    }
//}
//
//
//// Operation
//struct Operation: Codable {
//    let store: String
//}
