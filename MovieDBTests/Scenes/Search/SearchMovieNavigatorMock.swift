//
//  SearchMovieNavigatorMock.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB

final class SearchMovieNavigatorMock: SearchMovieNavigatorType {
    
    var toMovieDetailCalled = false
    
    func toMovieDetail(movie: Movie) {
        toMovieDetailCalled = true
    }
}
