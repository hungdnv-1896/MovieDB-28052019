//
//  CastDetailNavigatorMock.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB

final class CastDetailNavigatorMock: CastDetailNavigatorType {
    
    var backScreenCalled = false
    
    func backScreen() {
        backScreenCalled = true
    }
    
    var toMovieDetailCalled = false
    
    func toMovieDetail(movie: Movie) {
        toMovieDetailCalled = true
    }
}
