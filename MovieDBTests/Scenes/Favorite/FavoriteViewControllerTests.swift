//
//  FavoriteViewControllerTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import XCTest

final class FavoriteViewControllerTests: XCTest {
    private var viewController: FavoriteViewController!
    
    override func setUp() {
        super.setUp()
        viewController = FavoriteViewController.instantiate()
    }
    
    func test_ibOutlets() {
        _ = viewController.view
        XCTAssertNotNil(viewController.tableView)
    }
}
