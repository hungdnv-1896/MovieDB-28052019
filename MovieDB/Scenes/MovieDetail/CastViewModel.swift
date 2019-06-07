//
//  CastViewModel.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/6/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit

struct CastViewModel {
    let cast: Cast
    
    var id: Int {
        return cast.id
    }
    
    var name: String {
        return cast.name
    }
    
    var castId: Int {
        return cast.castId
    }
    
    var profileImageURL: URL? {
        return URL(string: API.Urls.baseURLImage + cast.profilePath)
    }
}
