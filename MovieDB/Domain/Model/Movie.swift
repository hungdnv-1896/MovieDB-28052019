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
    var posterPath: String
    var voteCount: Int
    var backdropPath: String
}

extension Movie {
    init() {
        self.init(
            id: 0,
            title: "",
            overview: "",
            posterPath: "",
            voteCount: 0,
            backdropPath: ""
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
        posterPath <- map["poster_path"]
        voteCount <- map["vote_count"]
        backdropPath <- map["backdrop_path"]
    }
}
