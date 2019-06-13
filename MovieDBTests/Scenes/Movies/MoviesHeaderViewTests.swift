//
//  MoviesHeaderViewTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/13/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import XCTest
@testable import MovieDB

final class MoviesHeaderTests: XCTestCase {
    var view: MoviesHeaderView!
    
    override func setUp() {
        super.setUp()
        view = MoviesHeaderView.loadFromNib()
    }
    
    func test_ibOutlets() {
        XCTAssertNotNil(view)
        XCTAssertNotNil(view.pagerView)
    }
}
