//
//  MovieFavorite.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/12/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

struct MovieFavorite {
    var id: String
    var title: String
    var posterPath: String
}

extension MovieFavorite {
    init() {
        self.init(
            id: "",
            title: "",
            posterPath: ""
        )
    }
}

extension MovieFavorite: Then, HasID, Hashable { }

// MARK: - CoreDataModel
extension MovieFavorite: CoreDataModel {
    static var primaryKey: String {
        return "id"
    }
    
    var modelID: String {
        return id
    }
}

