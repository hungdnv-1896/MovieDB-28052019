//
//  VideoTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/13/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import XCTest
@testable import MovieDB

final class VideoTest: XCTestCase {
    
    func test_mapping() {
        let json: [String: Any] = [
            "id": "123abc",
            "key": "Tony",
            "name": "Stark"
        ]
        let video = Video(JSON: json)
        
        XCTAssertNotNil(video)
        XCTAssertEqual(video?.id, json["id"] as? String)
        XCTAssertEqual(video?.key, json["key"] as? String)
        XCTAssertEqual(video?.name, json["name"] as? String)
    }
}

