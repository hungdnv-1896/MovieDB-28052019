//
//  CastDetailViewControllerTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import XCTest
import Reusable

final class CastDetailViewControllerTests: XCTest {
    private var viewController: CastDetailViewController!
    
    override func setUp() {
        super.setUp()
        viewController = CastDetailViewController.instantiate()
    }
    
    func test_ibOutlets() {
        _ = viewController.viewModel
        XCTAssertNotNil(viewController.castProfileImage)
        XCTAssertNotNil(viewController.castNameLabel)
        XCTAssertNotNil(viewController.knowForLabel)
        XCTAssertNotNil(viewController.genderLabel)
        XCTAssertNotNil(viewController.birthdayLabel)
        XCTAssertNotNil(viewController.placeOfBirthLabel)
        XCTAssertNotNil(viewController.biographyLabel)
        XCTAssertNotNil(viewController.movieTableView)
        XCTAssertNotNil(viewController.backButton)
    }
}
