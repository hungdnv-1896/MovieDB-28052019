//
//  MoviesNavigatorMock.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/13/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB

final class MoviesNavigatorMock: MoviesNavigatorType {
    
    // MARK: - toMovieCategory
    
    var toMovieCategoryCalled = false
    
    func toMovieCategory(category: CategoryType) {
        toMovieCategoryCalled = true
    }
    
    // MARK: toSearchMovie
    
    var toSearchMovieCalled = false
    
    func toSearchMovie() {
        toSearchMovieCalled = true
    }
    
    // MARK: toMovieDetail
    var toMovieDetailCalled = false
    
    func toMovieDetail(movie: Movie) {
        toMovieDetailCalled = true
    }
}
