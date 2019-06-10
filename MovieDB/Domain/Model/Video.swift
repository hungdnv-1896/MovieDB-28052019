//
//  Video.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/9/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import ObjectMapper

struct Video {
    var id: String
    var key: String
    var name: String
}

extension Video {
    init() {
        self.init(
            id: "",
            key: "",
            name: ""
        )
    }
}

extension Video: Then, HasID, Hashable {}

extension Video: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        key <- map["key"]
        name <- map["name"]
    }
}



