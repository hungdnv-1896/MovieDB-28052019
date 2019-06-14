//
//  MovieDetailNavigatorMock.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB

final class MovieDetailNavigatorMock: MovieDetailNavigatorType {
    
    //MARK: toCastDetail
    var toCastDetailCalled = false
    
    func toCastDetail(cast: Cast) {
        toCastDetailCalled = true
    }
    
    //MARK: backScreen
    var backScreenCalled = false
    
    func backScreen() {
        backScreenCalled = true
    }
    
    //MARK: toReviews
    var toReviewsCalled = false
    
    func toReviews(movie: Movie) {
        toReviewsCalled = true
    }
    
    //MARK: playTrailer
    var playTrailerCalled = false
    
    func playTrailler(movie: Movie) {
        playTrailerCalled = true
    }
}
