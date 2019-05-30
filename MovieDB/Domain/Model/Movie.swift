//
//  Movie.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 5/29/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import ObjectMapper

struct Movie {
    var id = 0
    var title: String
    var overview: String
    var poster_path: String
    var vote_count: Int
    var backdrop_path: String
}

extension Movie {
    init() {
        self.init(
            id: 0,
            title: "",
            overview: "",
            poster_path: "",
            vote_count: 0,
            backdrop_path: ""
        )
    }
}

extension Movie: Then, HasID, Hashable { }

extension Movie: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        overview <- map["overview"]
        poster_path <- map["poster_path"]
        vote_count <- map["vote_count"]
        backdrop_path <- map["backdrop_path"]
    }
}


