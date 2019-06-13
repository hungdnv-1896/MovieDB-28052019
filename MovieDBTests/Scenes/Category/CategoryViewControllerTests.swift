//
//  CategoryViewControllerTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/13/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import XCTest
import Reusable

final class CategoryViewControllerTests: XCTest {
    private var viewController: CategoryViewController!
    
    override func setUp() {
        super.setUp()
        viewController = CategoryViewController.instantiate()
    }
    
    func test_ibOutlets() {
        _ = viewController.view
        XCTAssertNotNil(viewController.tableView)
    }
}
