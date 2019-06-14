//
//  ReviewsViewControllerTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import XCTest

final class ReviewsViewControllerTests: XCTest {
    private var viewController: ReviewsMovieViewController!
    
    override func setUp() {
        super.setUp()
        viewController = ReviewsMovieViewController.instantiate()
    }
    
    func test_inOutlets() {
        _ = viewController.view
        XCTAssertNotNil(viewController.tableView)
    }
}
