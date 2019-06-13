//
//  MoviesViewControllerTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/13/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import XCTest
import Reusable

final class MoviesViewControllerTests: XCTestCase {
    
    private var viewController: MoviesViewController!
    
    override func setUp() {
        super.setUp()
        viewController = MoviesViewController.instantiate()
    }
    
    func test_ibOutlets() {
        _ = viewController.view
        XCTAssertNotNil(viewController.tableView)
    }
    
    func test_bindViewModel() {
        _ = viewController.view
        viewController.bindViewModel()
    }
}
