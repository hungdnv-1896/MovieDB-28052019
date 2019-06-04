//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/3/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import Foundation

import UIKit

struct MovieViewModel {
    let movie: Movie
    
    var name: String {
        return movie.title
    }
    
    var posterPath: String {
        return movie.posterPath
    }
    
    var backdropPath: String {
        return movie.backdropPath
    }
}
