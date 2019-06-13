//
//  MovieCellTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/13/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import XCTest
@testable import MovieDB

final class MovieCellTests: XCTestCase {
    var cell: MovieCell!
    
    override func setUp() {
        super.setUp()
        cell = MovieCell.loadFromNib()
    }
    
    func test_ibOutlets() {
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.moviePosterImage)
    }
}
