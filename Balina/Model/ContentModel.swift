//
//  ContentModel.swift
//  Balina
//
//  Created by Roman Bukh on 15.05.21.
//

import Foundation

struct GetResponse: Decodable {
    var page: Int
    var pageSize: Int
    var totalPages: Int
    var totalElements: Int
    var content: [Post]
}

struct Post: Decodable {
    var id: Int
    var name: String
    var image: String?
}
