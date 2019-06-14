//
//  SearchMovieViewControllerTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import XCTest
import Reusable

final class SearchMovieViewControllerTests: XCTest {
    
    private var viewController: SearchMovieViewController!
    
    override func setUp() {
        super.setUp()
        viewController = SearchMovieViewController.instantiate()
    }
    
    func test_ibOutlets() {
        _ = viewController.view
        XCTAssertNotNil(viewController.tableView)
    }
}
