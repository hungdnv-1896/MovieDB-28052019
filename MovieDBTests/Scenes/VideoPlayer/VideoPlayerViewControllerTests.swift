//
//  VideoPlayerViewControllerTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

@testable import MovieDB
import XCTest

final class VideoPlayerViewControllerTests: XCTest {
    private var viewController: VideoPlayerViewController!
    
    override func setUp() {
        super.setUp()
        viewController = VideoPlayerViewController.instantiate()
    }
    
    func test_ibOutlets() {
        _ = viewController.viewModel
        XCTAssertNotNil(viewController.tableView)
    }
}
