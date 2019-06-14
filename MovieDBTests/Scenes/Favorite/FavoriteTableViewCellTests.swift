//
//  FavoriteTableViewCellTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import XCTest
@testable import MovieDB

final class FavoriteTableViewCellTests: XCTestCase {
    var cell: FavoriteTableViewCell!
    
    override func setUp() {
        super.setUp()
        cell = FavoriteTableViewCell.loadFromNib()
    }
    
    func test_ibOutlets() {
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.posterImage)
        XCTAssertNotNil(cell.nameLabel)
        XCTAssertNotNil(cell.deleteButton(UIButton()))
    }
}
