//
//  Article.swift
//  MVVMDemo
//
//  Created by Ishi on 05/12/23.
//

import Foundation

class Article {
    
    var title :String
    var description :String

    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    init?(dictionary :JSONDictionary) {
        guard let title = dictionary["author"] as? String,
              let description = dictionary["description"] as? String else {
            return nil
        }
        self.title = title
        self.description = description
    }
}
