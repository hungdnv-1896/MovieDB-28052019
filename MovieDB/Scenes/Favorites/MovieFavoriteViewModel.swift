//
//  MovieFavoriteViewModel.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/12/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

struct MovieFavoriteViewModel {
    let movieFavorite: MovieFavorite
    
    var id: String {
        return movieFavorite.id
    }
    
    var title: String {
        return movieFavorite.title
    }
    
    var posterImageURL: URL? {
        return URL(string: API.Urls.baseURLImage + movieFavorite.posterPath)
    }
}
