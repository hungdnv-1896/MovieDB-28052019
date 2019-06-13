//
//  CategoryNavigatorMock.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/13/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB

final class CategoryNavigatorMock: CategoryNavigatorType {
    //MARK: toMovieDetail
    
    var toMovieDetailCalled = false
    
    func toMovieDetail(movie: Movie) {
        toMovieDetailCalled = true
    }
}
