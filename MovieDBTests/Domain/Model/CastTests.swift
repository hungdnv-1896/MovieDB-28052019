//
//  CastTests.swift
//  MovieDBTests
//
//  Created by nguyen.van.hungd on 6/14/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import XCTest
@testable import MovieDB

final class CastTest: XCTestCase {
    
    func test_mapping() {
        let json: [String: Any] = [
            "cast_id": 11,
            "name": "Tony",
            "id": 1,
            "gender": Gender.none,
            "profile_path": "/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg",
            "biography": "Description",
            "place_of_birth": "London",
            "birthday": Date().timeIntervalSince1970,
            "known_for_department": "Acting"
        ]
        let cast = Cast(JSON: json)
        
        XCTAssertNotNil(cast)
        XCTAssertEqual(cast?.id, json["id"] as? Int)
        XCTAssertEqual(cast?.name, json["name"] as? String)
        XCTAssertEqual(cast?.castId, json["cast_id"] as? Int)
        XCTAssertEqual(cast?.gender, json["gender"] as? Gender)
        XCTAssertEqual(cast?.profilePath, json["profile_path"] as? String)
        XCTAssertEqual(cast?.biography, json["biography"] as? String)
        XCTAssertEqual(cast?.placeOfBirth, json["place_of_birth"] as? String)
        XCTAssertEqual(cast?.knowFor, json["known_for_department"] as? String)
    }
}
