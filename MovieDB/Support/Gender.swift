//
//  Gender.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/7/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

enum Gender: Int {
    case none = 0
    case female = 1
    case male = 2
    
    var title: String {
        switch self {
        case .female:
            return "Female"
        case .male:
            return "Male"
        default:
            return "None"
        }
    }
}
