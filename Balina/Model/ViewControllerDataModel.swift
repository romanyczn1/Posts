//
//  ViewControllerDataModel.swift
//  Balina
//
//  Created by Roman Bukh on 15.05.21.
//

import Foundation
import UIKit

protocol ViewControllerDataModelDelegate: class {
    func updateTable()
}

final class ViewControllerDataModel {
    
    private let postsFetcher: PostsDataFetcher
    private let imagePusher: ImagePusher
    private var posts: [PostCellModel] = []
    private var pagesLoaded: Int = 0
    
    weak var delegate: ViewControllerDataModelDelegate!
    
    init() {
        self.postsFetcher = PostsFetcher()
        self.imagePusher = ImagePusher()
    }
    
    public func getPosts() {
        postsFetcher.fetchPosts(pageNumber: pagesLoaded) { [unowned self] (posts, error) in
            if posts != nil {
                if posts!.count != 0 {
                    let newPosts = posts!.map({ (post) -> PostCellModel in
                        return PostCellModel(id: post.id, title: post.name, imagePath: post.image)
                    })
                    self.posts.append(contentsOf: newPosts)
                    self.pagesLoaded += 1
                    self.delegate.updateTable()
                }
            } else {
                print("Error decoding")
            }
        }
    }
    
    public func pushImage(image: UIImage, postId: IndexPath) {
        imagePusher.pushIamge(image: image, postId: postId.row)
    }
    
    public func getNumberOfPosts() -> Int {
        return posts.count
    }
    
    public func getPost(for indexPath: IndexPath) -> PostCellModel {
        return posts[indexPath.row]
    }
}
