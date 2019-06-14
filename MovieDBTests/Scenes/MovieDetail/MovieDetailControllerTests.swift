//
//  MovieDetailControllerTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import Reusable
import XCTest

final class MovieDetailControllerTests: XCTest {
    
    private var viewController: MovieDetailViewController!
    
    override func setUp() {
        super.setUp()
        viewController = MovieDetailViewController.instantiate()
    }
    
    func test_ibOutlets() {
        _ = viewController.view
        XCTAssertNotNil(viewController.backDropImage)
        XCTAssertNotNil(viewController.posterImage)
        XCTAssertNotNil(viewController.movieNameLabel)
        XCTAssertNotNil(viewController.timeLabel)
        XCTAssertNotNil(viewController.overviewLabel)
        XCTAssertNotNil(viewController.castCollectionView)
        XCTAssertNotNil(viewController.rateView)
        XCTAssertNotNil(viewController.backButton)
        XCTAssertNotNil(viewController.trailerButton)
        XCTAssertNotNil(viewController.showReviewsButton)
        XCTAssertNotNil(viewController.addFavoriteButton)
    }
}
