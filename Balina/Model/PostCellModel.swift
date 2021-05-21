//
//  PostCellModel.swift
//  Balina
//
//  Created by Roman Bukh on 16.05.21.
//

import Foundation

class PostCellModel {
    
    var id: Int
    var title: String
    var imagePath: String?
    
    init(id: Int, title: String, imagePath: String?) {
        self.id = id
        self.title = title
        self.imagePath = imagePath
    }
}
