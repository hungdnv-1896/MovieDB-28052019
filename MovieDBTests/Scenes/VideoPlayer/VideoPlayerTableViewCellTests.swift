//
//  File.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import XCTest
@testable import MovieDB

final class VideoPlayerTableViewCellTests: XCTestCase {
    var cell: VideoPlayerTableViewCell!
    
    override func setUp() {
        super.setUp()
        cell = VideoPlayerTableViewCell.loadFromNib()
    }
    
    func test_ibOutlets() {
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.nameLabel)
        XCTAssertNotNil(cell.playerView)
    }
}
