
import UIKit

enum PostRenderType {
    case header(provider: PostViewData)
    case primaryContent(provider: PostViewData)
    case actions(provider: PostViewData)
    case descriptions(post: PostViewData)
    case comments(comments: [CommentViewData]  )
}

struct PostRenderViewModel {
    let renderType: PostRenderType
}

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let descriptions: PostRenderViewModel
    let comments: PostRenderViewModel
}
