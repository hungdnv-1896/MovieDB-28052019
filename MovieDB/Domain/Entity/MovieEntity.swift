//
//  MovieEntity.swift
//  MovieDB
//
//  Created by Nguyen Hung on 6/10/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import Realm
import RealmSwift

class MovieEntity: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var posterPath = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension MovieEntity {
    func toModel() -> Movie {
        var movie = Movie()
        movie.id = self.id
        movie.title = self.title
        movie.posterPath = self.posterPath
        return movie
    }
}
