//
//  VideoViewModel.swift
//  MovieDB
//
//  Created by nguyen.van.hungd on 6/10/19.
//  Copyright © 2019 nguyen.van.hungd. All rights reserved.
//

import UIKit

struct VideoViewModel {
    let video: Video
    
    var id: String {
        return video.id
    }
    
    var name: String {
        return video.name
    }
    
    var key: String {
        return video.key
    }
}
