//
//  PostsFetcher.swift
//  Balina
//
//  Created by Roman Bukh on 15.05.21.
//

import Foundation

protocol PostsDataFetcher: class {
    func fetchPosts(pageNumber: Int, completion: @escaping ([Post]?, Error?) -> ())
}

final class PostsFetcher: PostsDataFetcher {
    
    private let netwotkService: Networking
    
    init() {
        netwotkService = NetworkService()
    }
    
    func fetchPosts(pageNumber: Int, completion: @escaping ([Post]?, Error?) -> ()) {
        netwotkService.request(forString: "https://junior.balinasoft.com/api/v2/photo/type?page=\(pageNumber)") { (data, error) in
            if let data = data {
                let response = try? JSONDecoder().decode(GetResponse.self, from: data)
                completion(response?.content, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
