//
//  MovieTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 5/29/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import XCTest
@testable import MovieDB

final class MovieTests: XCTestCase {
    
    func test_mapping() {
        let json: [String: Any] = [
            "id": 1,
            "title": "Endgame",
            "overview": "Avenger",
            "vote_count": 10
        ]
        let movie = Movie(JSON: json)
        
        XCTAssertNotNil(movie)
        XCTAssertEqual(movie?.id, json["id"] as? Int)
        XCTAssertEqual(movie?.title, json["title"] as? String)
        XCTAssertEqual(movie?.overview, json["overview"] as? String)
        XCTAssertEqual(movie?.vote_count, json["vote_count"] as? Int)
    }
    
}
