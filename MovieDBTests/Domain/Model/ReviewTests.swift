//
//  ReviewTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/13/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import XCTest
@testable import MovieDB

final class ReviewTests: XCTestCase {
    func test_mapping() {
        let json: [String: Any] = [
            "id": "123abc",
            "author": "Tony",
            "content": "No Country for Old Men"
        ]
        let review = Review(JSON: json)
        
        XCTAssertNotNil(review)
        XCTAssertEqual(review?.id, json["id"] as? String)
        XCTAssertEqual(review?.author, json["author"] as? String)
        XCTAssertEqual(review?.content, json["content"] as? String)
    }
}
