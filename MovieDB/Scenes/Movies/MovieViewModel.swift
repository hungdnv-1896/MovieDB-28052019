//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/3/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit

struct MovieViewModel {
    let movie: Movie
    
    var id: Int {
        return movie.id
    }
    
    var name: String {
        return movie.title
    }
    
    var overview: String {
        return movie.overview
    }
    
    var voteCount: Int {
        return movie.voteCount
    }
    
    var posterImageURL: URL? {
        return URL(string: API.Urls.baseURLImage + movie.posterPath)
    }
    
    var backdropImageURL: URL? {
        return URL(string: API.Urls.baseURLImage + movie.backdropPath)
    }
    
    var runtime: Int {
        return movie.runtime
    }
    
    var castList: [Cast] {
        return movie.castList
    }
    
    var voteAverage: Double {
        return movie.voteAverage
    }
}
