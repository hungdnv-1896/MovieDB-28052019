//
//  Review.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/8/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import ObjectMapper

struct Review {
    var id: String
    var author: String
    var content: String
}

extension Review {
    init() {
        self.init(
            id: "",
            author: "",
            content: ""
        )
    }
}

extension Review: Then, HasID, Hashable {}

extension Review: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        author <- map["author"]
        content <- map["content"]
    }
}


