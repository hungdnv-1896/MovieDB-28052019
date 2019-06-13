//
//  MovieTableViewCellTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/13/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import XCTest

final class MovieTableViewCellTests: XCTestCase {
    var cell: MovieTableViewCell!
    
    override func setUp() {
        super.setUp()
        cell = MovieTableViewCell.loadFromNib()
    }
    
    func test_ibOutlets() {
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.nameLabel)
        XCTAssertNotNil(cell.posterImage)
    }
}
