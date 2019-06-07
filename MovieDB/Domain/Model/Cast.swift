//
//  Cast.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/6/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import ObjectMapper

struct Cast {
    var castId: Int
    var name: String
    var id: Int
    var profilePath: String
}

extension Cast {
    init() {
        self.init(
            castId: 0,
            name: "",
            id: 0,
            profilePath: ""
        )
    }
}

extension Cast: Then, HasID, Hashable { }

extension Cast: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        castId <- map["cast_id"]
        profilePath <- map["profile_path"]
    }
}

