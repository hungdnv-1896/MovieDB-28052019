//
//  ReviewTableViewCellTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import XCTest
@testable import MovieDB

final class ReviewTableViewCellTests: XCTestCase {
    var cell: ReviewTableViewCell!
    
    override func setUp() {
        super.setUp()
        cell = ReviewTableViewCell.loadFromNib()
    }
    
    func test_ibOutlets() {
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.reviewerLabel)
        XCTAssertNotNil(cell.contentLabel)
    }
}
