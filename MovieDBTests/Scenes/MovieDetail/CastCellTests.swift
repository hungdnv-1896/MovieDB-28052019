//
//  CastCellTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import XCTest
@testable import MovieDB

final class CastCellTests: XCTestCase {
    var cell: CastCell!
    
    override func setUp() {
        super.setUp()
        cell = CastCell.loadFromNib()
    }
    
    func test_ibOutlets() {
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.castImage)
        XCTAssertNotNil(cell.castNameLabel)
    }
}
